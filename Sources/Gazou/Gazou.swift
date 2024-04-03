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
            try handler.registerHandlers(on: router, serverURL: server, middlewares: [UnescapeLocationHeaderMiddleware()])
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

struct UnescapeLocationHeaderMiddleware: ServerMiddleware {
    func intercept(
        _ request: HTTPRequest,
        body: HTTPBody?,
        metadata: ServerRequestMetadata,
        operationID: String,
        next: (HTTPRequest, HTTPBody?, ServerRequestMetadata) async throws -> (HTTPResponse, HTTPBody?)
    ) async throws -> (HTTPResponse, HTTPBody?) {
        var (response, responseBody) = try await next(request, body, metadata)
        guard let location = response.headerFields[.location] else {
            return (response, responseBody)
        }
        response.headerFields[.location] = location.removingPercentEncoding
        return (response, responseBody)
    }
}
