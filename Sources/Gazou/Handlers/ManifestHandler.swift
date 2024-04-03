import Foundation
import Crypto
typealias Manifest = Components.Schemas.manifest

extension ManifestHandler {
    func getManifest(_ input: Operations.getManifest.Input) async throws -> Operations.getManifest.Output {
        let manifest = try store.pullManifest(input.path.repository, tagged: input.path.reference)
        return .ok(.init(body: .application_vnd_period_oci_period_image_period_manifest_period_v1_plus_json(manifest)))
    }
    
    func existsManifest(_ input: Operations.existsManifest.Input) async throws -> Operations.existsManifest.Output {
        return if store.existsManifest(input.path.repository, tagged: input.path.reference) {
            .ok(.init())
        } else {
            .notFound(.init())
        }
    }
}

extension Store {
    static let jsonDecoder = JSONDecoder()
    static let jsonEncoder = JSONEncoder()
    
    func namespaceManifest(_ repository: String) throws -> URL {
        let url = manifestLocation.appending(path: repository)
        try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
        
        return url
    }
    
    func existsManifest(_ repository: String, tagged reference: String) -> Bool {
        let location = manifestLocation.appending(path: repository)
        return FileManager.default.fileExists(atPath: location.appending(path: reference).path(percentEncoded: false))
    }
    
    func pullManifest(_ repository: String, tagged reference: String) throws -> Manifest {
        let location = manifestLocation.appending(path: repository)
        return try Self.jsonDecoder.decode(Manifest.self, from: Data(contentsOf: location))
    }
    
    func pushManifest(_ repository: String, tagged reference: String, manifest: Manifest) throws {
        let location = try namespaceManifest(repository)
        let tagLocation = location.appending(component: reference)
        
        let json = try Self.jsonEncoder.encode(manifest)
        let digestLocation = location.appending(component: SHA256.hash(data: json).compactMap { String(format: "%02x", $0) }.joined())
        
        if !FileManager.default.fileExists(atPath: digestLocation.path(percentEncoded: false)) {
            try json.write(to: digestLocation)
        }
        
        try FileManager.default.removeItem(at: tagLocation)
        try FileManager.default.createSymbolicLink(at: tagLocation, withDestinationURL: digestLocation)
    }
}
