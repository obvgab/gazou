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
    
    internal let uploadLocation: URL
    internal let blobLocation: URL
    internal let manifestLocation: URL
    
    internal let logger = Logger(label: "Store")
    
    init(_ storeLocation: URL) throws {
        self.storeLocation = storeLocation
        self.uploadLocation = storeLocation.appending(component: "upload")
        self.blobLocation = storeLocation.appending(component: "blobs")
        self.manifestLocation = storeLocation.appending(component: "manifests")
        
        try [uploadLocation, blobLocation, manifestLocation].forEach { storage in
            try FileManager.default.createDirectory(at: storage, withIntermediateDirectories: true)
        }
        
        logger.info("Established registry at \(storeLocation.standardizedFileURL)")
    }
}

extension Handler {
    init?(location: URL? = nil, server: URL) {
        guard let store = try? Store(location ?? .currentDirectory().appending(component: "registry")) else { return nil }
        self.store = store
        self.server = server
    }
}
