import Foundation
import OpenAPIRuntime
import Hummingbird

extension BlobHandler {
    func getBlob(_ input: Operations.getBlob.Input) async throws -> Operations.getBlob.Output {
        // Do we need the repository argument?
        let blob = HTTPBody(
            try await HTTPBody.ByteChunk(
                try store.asyncBlob(for: input.path.digest)))
        
        return .ok(.init(body: .application_vnd_period_oci_period_image_period_layer_period_v1_period_tar_plus_gzip(blob)))
    }
    
    func existsBlob(_ input: Operations.existsBlob.Input) async throws -> Operations.existsBlob.Output {
        return if store.existsBlob(for: input.path.digest) {
            .ok(.init())
        } else {
            .notFound(.init())
        }
    }
}

extension Store {
    func asyncBlob(for digest: String) throws -> FileHandle.AsyncBytes {
        try FileHandle(forReadingFrom: blobLocation.appending(component: digest)).bytes
    }
    
    func existsBlob(for digest: String) -> Bool {
        FileManager.default.fileExists(atPath: blobLocation.appending(component: digest).path(percentEncoded: false))
    }
}
