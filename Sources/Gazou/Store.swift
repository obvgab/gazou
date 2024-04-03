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
    
    func existsBlobFile(for digest: String) -> Bool {
        FileManager.default.fileExists(atPath: blobLocation.appending(path: digest).path(percentEncoded: false))
    }
    
    func createUploadFile(with uuid: UUID = UUID()) throws -> UUID {
        // Using this method because it can throw and doesn't require changing the URL into a string
        try "".write(to: uploadLocation.appending(path: uuid.uuidString), atomically: true, encoding: .utf8)
        return uuid
    }
    
    func acquireUploadFile(with uuid: UUID) throws -> FileHandle {
        try FileHandle(forWritingTo: uploadLocation.appending(path: uuid.uuidString))
    }
    
    func commitUploadFile(with uuid: UUID, to digest: String) throws {
        try FileManager.default.moveItem(at: uploadLocation.appending(path: uuid.uuidString), to: blobLocation.appending(path: digest))
    }
}

extension Handler {
    init?(location: URL? = nil, server: URL) {
        guard let store = try? Store(location ?? .currentDirectory().appending(path: "registry")) else { return nil }
        self.store = store
        self.server = server
    }
}
