import Foundation
import Logging

/// Storage interface for image blobs
///
/// Holds onto a directory for saving and loading blobs
/// `/upload` is the directory for active image uploads
/// `/blobs` is the directory for saved blobs
/// `/manifests` is the directory for manifests
struct Store {
    private let storeLocation: URL
    
    private let uploadLocation: URL
    private let blobLocation: URL
    private let manifestLocation: URL
    
    private let logger = Logger(label: "GazouStore")
    
    init(_ storeLocation: URL) throws {
        self.storeLocation = storeLocation
        self.uploadLocation = storeLocation.appending(path: "upload")
        self.blobLocation = storeLocation.appending(path: "blobs")
        self.manifestLocation = storeLocation.appending(path: "manifests")
        
        try [uploadLocation, blobLocation, manifestLocation].forEach { storage in
            try FileManager.default.createDirectory(at: storage, withIntermediateDirectories: true)
        }
        
        logger.info("Established registry at \(storeLocation.standardizedFileURL)")
    }
    
    func asyncBlobFile(for digest: String) throws -> FileHandle.AsyncBytes {
        try FileHandle(forReadingFrom: blobLocation.appending(path: digest)).bytes
    }
}

extension Handler {
    init?(location: URL? = nil) {
        guard let store = try? Store(location ?? .currentDirectory().appending(path: "registry")) else { return nil }
        self.store = store
    }
}
