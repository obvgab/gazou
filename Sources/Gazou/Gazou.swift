import Hummingbird
import OpenAPIRuntime
import OpenAPIHummingbird

@main
struct Gazou {
    public static func main() async throws {
        let router = Router()

        try await Application(router: router).run()
    }
}