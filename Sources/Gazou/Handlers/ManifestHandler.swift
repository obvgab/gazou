import Foundation
typealias Manifest = Components.Schemas.manifest

extension ManifestHandler {
    func getManifest(_ input: Operations.getManifest.Input) async throws -> Operations.getManifest.Output {
        let manifest = try store.getManifest(input.path.repository, tagged: input.path.reference)
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
        let url = manifestLocation.appending(component: repository)
        try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
        
        return url
    }
    
    func existsManifest(_ repository: String, tagged reference: String) -> Bool {
        let location = manifestLocation.appending(component: repository)
        return FileManager.default.fileExists(atPath: location.appending(path: reference).path(percentEncoded: false))
    }
    
    func getManifest(_ repository: String, tagged reference: String) throws -> Manifest {
        let location = manifestLocation.appending(component: repository)
        return try Self.jsonDecoder.decode(Manifest.self, from: Data(contentsOf: location))
    }
}
