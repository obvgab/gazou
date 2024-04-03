import Foundation
import OpenAPIRuntime

extension UploadHandler {
    func startUploadBlob(_ input: Operations.startUploadBlob.Input) async throws -> Operations.startUploadBlob.Output {
        let uuid = try store.createUploadFile()
        let location = server.appending(components: input.path.repository, "blobs", "upload", uuid.uuidString)
        
        return .accepted(.init(headers: .init(Location: location.absoluteString, Docker_hyphen_Upload_hyphen_UUID: uuid.uuidString)))
    }
    
    func continueUploadBlob(_ input: Operations.continueUploadBlob.Input) async throws -> Operations.continueUploadBlob.Output {
        guard let uuid = UUID(uuidString: input.path.uuid),
              let body = input.body else { return .internalServerError(.init()) }
        
        let file = try store.acquireUploadFile(with: uuid)
        let location = server.appending(components: input.path.repository, "blobs", "upload", uuid.uuidString)
        
        let binary: HTTPBody
        switch body { case .binary(let httpData): binary = httpData }
        
        var wrote = 0
        for try await data in binary { try file.write(contentsOf: data); wrote += 1 }
        return .accepted(.init(headers: .init(
            Location: location.absoluteString,
            Docker_hyphen_Upload_hyphen_UUID: uuid.uuidString,
            Content_hyphen_Length: 0,
            Content_hyphen_Range: "0-\(wrote)"))
        )
    }
    
    func finishUploadBlob(_ input: Operations.finishUploadBlob.Input) async throws -> Operations.finishUploadBlob.Output {
        guard let uuid = UUID(uuidString: input.path.uuid) else { return .internalServerError(.init()) }
        
        try store.commitUploadFile(with: uuid, to: input.query.digest)
        return .created(.init(headers: .init(
            Content_hyphen_Length: 0,
            Docker_hyphen_Content_hyphen_Digest: input.query.digest))
        )
    }
}
