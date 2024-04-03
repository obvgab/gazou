import Hummingbird
import Foundation
import OpenAPIRuntime
import OpenAPIHummingbird
import Logging

@main
struct Gazou {
    static let logger = Logger(label: "Gazou")
    
    public static func main() async throws {
        let router = Router()
        let server = try Servers.server1()
        
        if let handler = Handler(server: server) {
            try handler.registerHandlers(on: router, serverURL: server)
        }

        try await Application(router: router, configuration: .init(
            address: .hostname(server.host(percentEncoded: false)!,
                               port: server.port!))
        ).run()
    }
}

struct Handler: APIProtocol { let store: Store; let server: URL }
typealias BlobHandler = Handler
typealias ManifestHandler = Handler
typealias UploadHandler = Handler
typealias AuthenticationHandler = Handler
