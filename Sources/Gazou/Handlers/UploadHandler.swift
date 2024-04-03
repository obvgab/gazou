import Foundation
import OpenAPIRuntime
import Crypto
import Logging

extension UploadHandler {
    static let uploadLogger = Logger(label: "Upload")
    
    func startUploadBlob(_ input: Operations.startUploadBlob.Input) async throws -> Operations.startUploadBlob.Output {
        let uuid = try store.createUploadFile()
        let location = server.appending(components: input.path.repository, "blobs", "upload", uuid.uuidString)

        Self.uploadLogger.debug("Started upload session for \(input.path.repository) with location \(location.absoluteString)")
        
        return .accepted(.init(headers: .init(Location: location.absoluteString, Docker_hyphen_Upload_hyphen_UUID: uuid.uuidString)))
    }
    
    func continueUploadBlob(_ input: Operations.continueUploadBlob.Input) async throws -> Operations.continueUploadBlob.Output {
        Self.uploadLogger.debug("Began upload for chunk on \(input.path.uuid)")
        
        guard let uuid = UUID(uuidString: input.path.uuid),
              let body = input.body else { return .internalServerError(.init()) }
        
        let file = try store.acquireUploadFile(with: uuid)
        let location = server.appending(components: input.path.repository, "blobs", "upload", uuid.uuidString)
        
        let binary: HTTPBody
        switch body { case .binary(let httpData): binary = httpData }
        
        var wrote = 0
        for try await data in binary { try file.write(contentsOf: data); wrote += 1 }
        defer { Self.uploadLogger.debug("Finished upload for chunk on \(input.path.uuid) with \(wrote) bytes") }
        
        return .accepted(.init(headers: .init( // Something isn't working here
            Location: location.absoluteString,
            Docker_hyphen_Upload_hyphen_UUID: uuid.uuidString,
            Content_hyphen_Length: 0,
            Content_hyphen_Range: "0-\(wrote)"))
        )
    }
    
    func finishUploadBlob(_ input: Operations.finishUploadBlob.Input) async throws -> Operations.finishUploadBlob.Output {
        guard let uuid = UUID(uuidString: input.path.uuid) else { return .internalServerError(.init()) }
        
        try store.commitUploadFile(with: uuid, to: input.query.digest)
        Self.uploadLogger.info("Finished upload for blob \(uuid) on repository \(input.path.repository)")
        return .created(.init(headers: .init(
            Content_hyphen_Length: 0,
            Docker_hyphen_Content_hyphen_Digest: input.query.digest))
        )
    }
    
    func uploadManifest(_ input: Operations.uploadManifest.Input) async throws -> Operations.uploadManifest.Output {
        guard let body = input.body else { return .internalServerError(.init()) }
        
        let manifest: Manifest
        switch body { case .application_vnd_period_oci_period_image_period_manifest_period_v1_plus_json(let json): manifest = json }
        
        let digest = try store.uploadManifest(input.path.repository, tagged: input.path.reference, manifest: manifest)
        let location = server.appending(components: input.path.repository, "manifests", input.path.reference)
        
        return .created(.init(headers: .init(Location: location.absoluteString, Docker_hyphen_Content_hyphen_Digest: digest)))
    }
}

extension Store {
    func createUploadFile(with uuid: UUID = UUID()) throws -> UUID {
        // Using this method because it can throw and doesn't require changing the URL into a string
        try "".write(to: uploadLocation.appending(component: uuid.uuidString), atomically: true, encoding: .utf8)
        return uuid
    }
    
    func acquireUploadFile(with uuid: UUID) throws -> FileHandle {
        try FileHandle(forWritingTo: uploadLocation.appending(path: uuid.uuidString))
    }
    
    func commitUploadFile(with uuid: UUID, to digest: String) throws {
        try FileManager.default.moveItem(at: uploadLocation.appending(component: uuid.uuidString), to: blobLocation.appending(component: digest))
    }
    
    func uploadManifest(_ repository: String, tagged reference: String, manifest: Manifest) throws -> String {
        let location = try namespaceManifest(repository)
        let tagLocation = location.appending(component: reference)
        
        let json = try Self.jsonEncoder.encode(manifest)
        let digest = SHA256.hash(data: json).compactMap { String(format: "%02x", $0) }.joined()
        let digestLocation = location.appending(component: digest)
        
        if !FileManager.default.fileExists(atPath: digestLocation.path(percentEncoded: false)) {
            try json.write(to: digestLocation)
        }
        
        try FileManager.default.removeItem(at: tagLocation)
        try FileManager.default.createSymbolicLink(at: tagLocation, withDestinationURL: digestLocation)
        
        return digest
    }
}
