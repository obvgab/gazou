import Hummingbird
import OpenAPIRuntime
import OpenAPIHummingbird
import Logging

@main
struct Gazou {
    static let logger = Logger(label: "Gazou")
    
    public static func main() async throws {
        let router = Router()
        
        if let handler = Handler() {
            try handler.registerHandlers(on: router)
        }

        try await Application(router: router, configuration: .init(address: .hostname("0.0.0.0", port: 8080))).run()
    }
}

struct Handler: APIProtocol { let store: Store }
typealias BlobHandler = Handler
typealias ManifestHandler = Handler
typealias UploadHandler = Handler
typealias AuthenticationHandler = Handler
