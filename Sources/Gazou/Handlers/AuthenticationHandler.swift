extension AuthenticationHandler {
    func getApiVersion(_ input: Operations.getApiVersion.Input) async throws -> Operations.getApiVersion.Output {
        // TEMP
        .ok(.init(body: .json(.init())))
    }
}
