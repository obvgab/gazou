// Generated by swift-openapi-generator, do not modify.
@_spi(Generated) import OpenAPIRuntime
#if os(Linux)
@preconcurrency import struct Foundation.URL
@preconcurrency import struct Foundation.Data
@preconcurrency import struct Foundation.Date
#else
import struct Foundation.URL
import struct Foundation.Data
import struct Foundation.Date
#endif
/// A type that performs HTTP operations defined by the OpenAPI document.
internal protocol APIProtocol: Sendable {
    /// API version check
    ///
    /// - Remark: HTTP `GET //`.
    /// - Remark: Generated from `#/paths////get(getApiVersion)`.
    func getApiVersion(_ input: Operations.getApiVersion.Input) async throws -> Operations.getApiVersion.Output
    /// Retrieve an image manifest
    ///
    /// - Remark: HTTP `GET /{repository}/manifests/{reference}`.
    /// - Remark: Generated from `#/paths//{repository}/manifests/{reference}/get(getManifest)`.
    func getManifest(_ input: Operations.getManifest.Input) async throws -> Operations.getManifest.Output
    /// Check if an image exists in the registry
    ///
    /// - Remark: HTTP `HEAD /{repository}/manifests/{reference}`.
    /// - Remark: Generated from `#/paths//{repository}/manifests/{reference}/head(existsImage)`.
    func existsImage(_ input: Operations.existsImage.Input) async throws -> Operations.existsImage.Output
    /// Retrieve a blob from an image
    ///
    /// - Remark: HTTP `GET /{repository}/blobs/{digest}`.
    /// - Remark: Generated from `#/paths//{repository}/blobs/{digest}/get(getBlob)`.
    func getBlob(_ input: Operations.getBlob.Input) async throws -> Operations.getBlob.Output
    /// Check if a blob exists in the registry
    ///
    /// - Remark: HTTP `HEAD /{repository}/blobs/{digest}`.
    /// - Remark: Generated from `#/paths//{repository}/blobs/{digest}/head(existsBlob)`.
    func existsBlob(_ input: Operations.existsBlob.Input) async throws -> Operations.existsBlob.Output
}

/// Convenience overloads for operation inputs.
extension APIProtocol {
    /// API version check
    ///
    /// - Remark: HTTP `GET //`.
    /// - Remark: Generated from `#/paths////get(getApiVersion)`.
    internal func getApiVersion(headers: Operations.getApiVersion.Input.Headers = .init()) async throws -> Operations.getApiVersion.Output {
        try await getApiVersion(Operations.getApiVersion.Input(headers: headers))
    }
    /// Retrieve an image manifest
    ///
    /// - Remark: HTTP `GET /{repository}/manifests/{reference}`.
    /// - Remark: Generated from `#/paths//{repository}/manifests/{reference}/get(getManifest)`.
    internal func getManifest(
        path: Operations.getManifest.Input.Path,
        headers: Operations.getManifest.Input.Headers = .init()
    ) async throws -> Operations.getManifest.Output {
        try await getManifest(Operations.getManifest.Input(
            path: path,
            headers: headers
        ))
    }
    /// Check if an image exists in the registry
    ///
    /// - Remark: HTTP `HEAD /{repository}/manifests/{reference}`.
    /// - Remark: Generated from `#/paths//{repository}/manifests/{reference}/head(existsImage)`.
    internal func existsImage(path: Operations.existsImage.Input.Path) async throws -> Operations.existsImage.Output {
        try await existsImage(Operations.existsImage.Input(path: path))
    }
    /// Retrieve a blob from an image
    ///
    /// - Remark: HTTP `GET /{repository}/blobs/{digest}`.
    /// - Remark: Generated from `#/paths//{repository}/blobs/{digest}/get(getBlob)`.
    internal func getBlob(path: Operations.getBlob.Input.Path) async throws -> Operations.getBlob.Output {
        try await getBlob(Operations.getBlob.Input(path: path))
    }
    /// Check if a blob exists in the registry
    ///
    /// - Remark: HTTP `HEAD /{repository}/blobs/{digest}`.
    /// - Remark: Generated from `#/paths//{repository}/blobs/{digest}/head(existsBlob)`.
    internal func existsBlob(path: Operations.existsBlob.Input.Path) async throws -> Operations.existsBlob.Output {
        try await existsBlob(Operations.existsBlob.Input(path: path))
    }
}

/// Server URLs defined in the OpenAPI document.
internal enum Servers {
    /// Primary BinarySky deployment
    internal static func server1() throws -> Foundation.URL {
        try Foundation.URL(
            validatingOpenAPIServerURL: "https://neptune.binarysky.ai/v2",
            variables: []
        )
    }
}

/// Types generated from the components section of the OpenAPI document.
internal enum Components {
    /// Types generated from the `#/components/schemas` section of the OpenAPI document.
    internal enum Schemas {
        /// - Remark: Generated from `#/components/schemas/descriptor`.
        internal struct descriptor: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/descriptor/mediaType`.
            internal var mediaType: Swift.String
            /// - Remark: Generated from `#/components/schemas/descriptor/digest`.
            internal var digest: Swift.String
            /// - Remark: Generated from `#/components/schemas/descriptor/size`.
            internal var size: Swift.Int
            /// - Remark: Generated from `#/components/schemas/descriptor/urls`.
            internal var urls: [Swift.String]?
            /// - Remark: Generated from `#/components/schemas/descriptor/annotations`.
            internal struct annotationsPayload: Codable, Hashable, Sendable {
                /// A container of undocumented properties.
                internal var additionalProperties: [String: Swift.String]
                /// Creates a new `annotationsPayload`.
                ///
                /// - Parameters:
                ///   - additionalProperties: A container of undocumented properties.
                internal init(additionalProperties: [String: Swift.String] = .init()) {
                    self.additionalProperties = additionalProperties
                }
                internal init(from decoder: any Decoder) throws {
                    additionalProperties = try decoder.decodeAdditionalProperties(knownKeys: [])
                }
                internal func encode(to encoder: any Encoder) throws {
                    try encoder.encodeAdditionalProperties(additionalProperties)
                }
            }
            /// - Remark: Generated from `#/components/schemas/descriptor/annotations`.
            internal var annotations: Components.Schemas.descriptor.annotationsPayload?
            /// - Remark: Generated from `#/components/schemas/descriptor/data`.
            internal var data: Swift.String?
            /// - Remark: Generated from `#/components/schemas/descriptor/artifactType`.
            internal var artifactType: Swift.String?
            /// Creates a new `descriptor`.
            ///
            /// - Parameters:
            ///   - mediaType:
            ///   - digest:
            ///   - size:
            ///   - urls:
            ///   - annotations:
            ///   - data:
            ///   - artifactType:
            internal init(
                mediaType: Swift.String,
                digest: Swift.String,
                size: Swift.Int,
                urls: [Swift.String]? = nil,
                annotations: Components.Schemas.descriptor.annotationsPayload? = nil,
                data: Swift.String? = nil,
                artifactType: Swift.String? = nil
            ) {
                self.mediaType = mediaType
                self.digest = digest
                self.size = size
                self.urls = urls
                self.annotations = annotations
                self.data = data
                self.artifactType = artifactType
            }
            internal enum CodingKeys: String, CodingKey {
                case mediaType
                case digest
                case size
                case urls
                case annotations
                case data
                case artifactType
            }
        }
        /// - Remark: Generated from `#/components/schemas/manifest`.
        internal struct manifest: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/manifest/schemaVersion`.
            internal var schemaVersion: Swift.Int
            /// - Remark: Generated from `#/components/schemas/manifest/mediaType`.
            internal var mediaType: Swift.String?
            /// - Remark: Generated from `#/components/schemas/manifest/artifactType`.
            internal var artifactType: Swift.String?
            /// - Remark: Generated from `#/components/schemas/manifest/config`.
            internal var config: Components.Schemas.descriptor
            /// - Remark: Generated from `#/components/schemas/manifest/layers`.
            internal var layers: [Components.Schemas.descriptor]?
            /// - Remark: Generated from `#/components/schemas/manifest/subject`.
            internal var subject: Components.Schemas.descriptor?
            /// - Remark: Generated from `#/components/schemas/manifest/annotations`.
            internal struct annotationsPayload: Codable, Hashable, Sendable {
                /// A container of undocumented properties.
                internal var additionalProperties: [String: Swift.String]
                /// Creates a new `annotationsPayload`.
                ///
                /// - Parameters:
                ///   - additionalProperties: A container of undocumented properties.
                internal init(additionalProperties: [String: Swift.String] = .init()) {
                    self.additionalProperties = additionalProperties
                }
                internal init(from decoder: any Decoder) throws {
                    additionalProperties = try decoder.decodeAdditionalProperties(knownKeys: [])
                }
                internal func encode(to encoder: any Encoder) throws {
                    try encoder.encodeAdditionalProperties(additionalProperties)
                }
            }
            /// - Remark: Generated from `#/components/schemas/manifest/annotations`.
            internal var annotations: Components.Schemas.manifest.annotationsPayload?
            /// Creates a new `manifest`.
            ///
            /// - Parameters:
            ///   - schemaVersion:
            ///   - mediaType:
            ///   - artifactType:
            ///   - config:
            ///   - layers:
            ///   - subject:
            ///   - annotations:
            internal init(
                schemaVersion: Swift.Int,
                mediaType: Swift.String? = nil,
                artifactType: Swift.String? = nil,
                config: Components.Schemas.descriptor,
                layers: [Components.Schemas.descriptor]? = nil,
                subject: Components.Schemas.descriptor? = nil,
                annotations: Components.Schemas.manifest.annotationsPayload? = nil
            ) {
                self.schemaVersion = schemaVersion
                self.mediaType = mediaType
                self.artifactType = artifactType
                self.config = config
                self.layers = layers
                self.subject = subject
                self.annotations = annotations
            }
            internal enum CodingKeys: String, CodingKey {
                case schemaVersion
                case mediaType
                case artifactType
                case config
                case layers
                case subject
                case annotations
            }
        }
    }
    /// Types generated from the `#/components/parameters` section of the OpenAPI document.
    internal enum Parameters {}
    /// Types generated from the `#/components/requestBodies` section of the OpenAPI document.
    internal enum RequestBodies {}
    /// Types generated from the `#/components/responses` section of the OpenAPI document.
    internal enum Responses {}
    /// Types generated from the `#/components/headers` section of the OpenAPI document.
    internal enum Headers {}
}

/// API operations, with input and output types, generated from `#/paths` in the OpenAPI document.
internal enum Operations {
    /// API version check
    ///
    /// - Remark: HTTP `GET //`.
    /// - Remark: Generated from `#/paths////get(getApiVersion)`.
    internal enum getApiVersion {
        internal static let id: Swift.String = "getApiVersion"
        internal struct Input: Sendable, Hashable {
            /// - Remark: Generated from `#/paths/GET/header`.
            internal struct Headers: Sendable, Hashable {
                internal var accept: [OpenAPIRuntime.AcceptHeaderContentType<Operations.getApiVersion.AcceptableContentType>]
                /// Creates a new `Headers`.
                ///
                /// - Parameters:
                ///   - accept:
                internal init(accept: [OpenAPIRuntime.AcceptHeaderContentType<Operations.getApiVersion.AcceptableContentType>] = .defaultValues()) {
                    self.accept = accept
                }
            }
            internal var headers: Operations.getApiVersion.Input.Headers
            /// Creates a new `Input`.
            ///
            /// - Parameters:
            ///   - headers:
            internal init(headers: Operations.getApiVersion.Input.Headers = .init()) {
                self.headers = headers
            }
        }
        @frozen internal enum Output: Sendable, Hashable {
            internal struct Ok: Sendable, Hashable {
                /// - Remark: Generated from `#/paths/GET/responses/200/content`.
                @frozen internal enum Body: Sendable, Hashable {
                    /// - Remark: Generated from `#/paths/GET/responses/200/content/application\/json`.
                    case json(OpenAPIRuntime.OpenAPIObjectContainer)
                    /// The associated value of the enum case if `self` is `.json`.
                    ///
                    /// - Throws: An error if `self` is not `.json`.
                    /// - SeeAlso: `.json`.
                    internal var json: OpenAPIRuntime.OpenAPIObjectContainer {
                        get throws {
                            switch self {
                            case let .json(body):
                                return body
                            }
                        }
                    }
                }
                /// Received HTTP response body
                internal var body: Operations.getApiVersion.Output.Ok.Body
                /// Creates a new `Ok`.
                ///
                /// - Parameters:
                ///   - body: Received HTTP response body
                internal init(body: Operations.getApiVersion.Output.Ok.Body) {
                    self.body = body
                }
            }
            /// API version information.
            ///
            /// - Remark: Generated from `#/paths////get(getApiVersion)/responses/200`.
            ///
            /// HTTP response code: `200 ok`.
            case ok(Operations.getApiVersion.Output.Ok)
            /// The associated value of the enum case if `self` is `.ok`.
            ///
            /// - Throws: An error if `self` is not `.ok`.
            /// - SeeAlso: `.ok`.
            internal var ok: Operations.getApiVersion.Output.Ok {
                get throws {
                    switch self {
                    case let .ok(response):
                        return response
                    default:
                        try throwUnexpectedResponseStatus(
                            expectedStatus: "ok",
                            response: self
                        )
                    }
                }
            }
            /// Undocumented response.
            ///
            /// A response with a code that is not documented in the OpenAPI document.
            case undocumented(statusCode: Swift.Int, OpenAPIRuntime.UndocumentedPayload)
        }
        @frozen internal enum AcceptableContentType: AcceptableProtocol {
            case json
            case other(Swift.String)
            internal init?(rawValue: Swift.String) {
                switch rawValue.lowercased() {
                case "application/json":
                    self = .json
                default:
                    self = .other(rawValue)
                }
            }
            internal var rawValue: Swift.String {
                switch self {
                case let .other(string):
                    return string
                case .json:
                    return "application/json"
                }
            }
            internal static var allCases: [Self] {
                [
                    .json
                ]
            }
        }
    }
    /// Retrieve an image manifest
    ///
    /// - Remark: HTTP `GET /{repository}/manifests/{reference}`.
    /// - Remark: Generated from `#/paths//{repository}/manifests/{reference}/get(getManifest)`.
    internal enum getManifest {
        internal static let id: Swift.String = "getManifest"
        internal struct Input: Sendable, Hashable {
            /// - Remark: Generated from `#/paths/{repository}/manifests/{reference}/GET/path`.
            internal struct Path: Sendable, Hashable {
                /// Namespace of the repository
                ///
                /// - Remark: Generated from `#/paths/{repository}/manifests/{reference}/GET/path/repository`.
                internal var repository: Swift.String
                /// Either a manifest's digest or a tag
                ///
                /// - Remark: Generated from `#/paths/{repository}/manifests/{reference}/GET/path/reference`.
                internal var reference: Swift.String
                /// Creates a new `Path`.
                ///
                /// - Parameters:
                ///   - repository: Namespace of the repository
                ///   - reference: Either a manifest's digest or a tag
                internal init(
                    repository: Swift.String,
                    reference: Swift.String
                ) {
                    self.repository = repository
                    self.reference = reference
                }
            }
            internal var path: Operations.getManifest.Input.Path
            /// - Remark: Generated from `#/paths/{repository}/manifests/{reference}/GET/header`.
            internal struct Headers: Sendable, Hashable {
                internal var accept: [OpenAPIRuntime.AcceptHeaderContentType<Operations.getManifest.AcceptableContentType>]
                /// Creates a new `Headers`.
                ///
                /// - Parameters:
                ///   - accept:
                internal init(accept: [OpenAPIRuntime.AcceptHeaderContentType<Operations.getManifest.AcceptableContentType>] = .defaultValues()) {
                    self.accept = accept
                }
            }
            internal var headers: Operations.getManifest.Input.Headers
            /// Creates a new `Input`.
            ///
            /// - Parameters:
            ///   - path:
            ///   - headers:
            internal init(
                path: Operations.getManifest.Input.Path,
                headers: Operations.getManifest.Input.Headers = .init()
            ) {
                self.path = path
                self.headers = headers
            }
        }
        @frozen internal enum Output: Sendable, Hashable {
            internal struct Ok: Sendable, Hashable {
                /// - Remark: Generated from `#/paths/{repository}/manifests/{reference}/GET/responses/200/content`.
                @frozen internal enum Body: Sendable, Hashable {
                    /// - Remark: Generated from `#/paths/{repository}/manifests/{reference}/GET/responses/200/content/application\/vnd.docker.distribution.manifest.v2+json`.
                    case application_vnd_period_docker_period_distribution_period_manifest_period_v2_plus_json(Components.Schemas.manifest)
                    /// The associated value of the enum case if `self` is `.application_vnd_period_docker_period_distribution_period_manifest_period_v2_plus_json`.
                    ///
                    /// - Throws: An error if `self` is not `.application_vnd_period_docker_period_distribution_period_manifest_period_v2_plus_json`.
                    /// - SeeAlso: `.application_vnd_period_docker_period_distribution_period_manifest_period_v2_plus_json`.
                    internal var application_vnd_period_docker_period_distribution_period_manifest_period_v2_plus_json: Components.Schemas.manifest {
                        get throws {
                            switch self {
                            case let .application_vnd_period_docker_period_distribution_period_manifest_period_v2_plus_json(body):
                                return body
                            }
                        }
                    }
                }
                /// Received HTTP response body
                internal var body: Operations.getManifest.Output.Ok.Body
                /// Creates a new `Ok`.
                ///
                /// - Parameters:
                ///   - body: Received HTTP response body
                internal init(body: Operations.getManifest.Output.Ok.Body) {
                    self.body = body
                }
            }
            /// Requested manifest of image
            ///
            /// - Remark: Generated from `#/paths//{repository}/manifests/{reference}/get(getManifest)/responses/200`.
            ///
            /// HTTP response code: `200 ok`.
            case ok(Operations.getManifest.Output.Ok)
            /// The associated value of the enum case if `self` is `.ok`.
            ///
            /// - Throws: An error if `self` is not `.ok`.
            /// - SeeAlso: `.ok`.
            internal var ok: Operations.getManifest.Output.Ok {
                get throws {
                    switch self {
                    case let .ok(response):
                        return response
                    default:
                        try throwUnexpectedResponseStatus(
                            expectedStatus: "ok",
                            response: self
                        )
                    }
                }
            }
            internal struct NotFound: Sendable, Hashable {
                /// Creates a new `NotFound`.
                internal init() {}
            }
            /// Image manifest not found
            ///
            /// - Remark: Generated from `#/paths//{repository}/manifests/{reference}/get(getManifest)/responses/404`.
            ///
            /// HTTP response code: `404 notFound`.
            case notFound(Operations.getManifest.Output.NotFound)
            /// The associated value of the enum case if `self` is `.notFound`.
            ///
            /// - Throws: An error if `self` is not `.notFound`.
            /// - SeeAlso: `.notFound`.
            internal var notFound: Operations.getManifest.Output.NotFound {
                get throws {
                    switch self {
                    case let .notFound(response):
                        return response
                    default:
                        try throwUnexpectedResponseStatus(
                            expectedStatus: "notFound",
                            response: self
                        )
                    }
                }
            }
            /// Undocumented response.
            ///
            /// A response with a code that is not documented in the OpenAPI document.
            case undocumented(statusCode: Swift.Int, OpenAPIRuntime.UndocumentedPayload)
        }
        @frozen internal enum AcceptableContentType: AcceptableProtocol {
            case application_vnd_period_docker_period_distribution_period_manifest_period_v2_plus_json
            case other(Swift.String)
            internal init?(rawValue: Swift.String) {
                switch rawValue.lowercased() {
                case "application/vnd.docker.distribution.manifest.v2+json":
                    self = .application_vnd_period_docker_period_distribution_period_manifest_period_v2_plus_json
                default:
                    self = .other(rawValue)
                }
            }
            internal var rawValue: Swift.String {
                switch self {
                case let .other(string):
                    return string
                case .application_vnd_period_docker_period_distribution_period_manifest_period_v2_plus_json:
                    return "application/vnd.docker.distribution.manifest.v2+json"
                }
            }
            internal static var allCases: [Self] {
                [
                    .application_vnd_period_docker_period_distribution_period_manifest_period_v2_plus_json
                ]
            }
        }
    }
    /// Check if an image exists in the registry
    ///
    /// - Remark: HTTP `HEAD /{repository}/manifests/{reference}`.
    /// - Remark: Generated from `#/paths//{repository}/manifests/{reference}/head(existsImage)`.
    internal enum existsImage {
        internal static let id: Swift.String = "existsImage"
        internal struct Input: Sendable, Hashable {
            /// - Remark: Generated from `#/paths/{repository}/manifests/{reference}/HEAD/path`.
            internal struct Path: Sendable, Hashable {
                /// Namespace of the repository
                ///
                /// - Remark: Generated from `#/paths/{repository}/manifests/{reference}/HEAD/path/repository`.
                internal var repository: Swift.String
                /// Either a manifest's digest or a tag
                ///
                /// - Remark: Generated from `#/paths/{repository}/manifests/{reference}/HEAD/path/reference`.
                internal var reference: Swift.String
                /// Creates a new `Path`.
                ///
                /// - Parameters:
                ///   - repository: Namespace of the repository
                ///   - reference: Either a manifest's digest or a tag
                internal init(
                    repository: Swift.String,
                    reference: Swift.String
                ) {
                    self.repository = repository
                    self.reference = reference
                }
            }
            internal var path: Operations.existsImage.Input.Path
            /// Creates a new `Input`.
            ///
            /// - Parameters:
            ///   - path:
            internal init(path: Operations.existsImage.Input.Path) {
                self.path = path
            }
        }
        @frozen internal enum Output: Sendable, Hashable {
            internal struct Ok: Sendable, Hashable {
                /// Creates a new `Ok`.
                internal init() {}
            }
            /// Image exists on the registry
            ///
            /// - Remark: Generated from `#/paths//{repository}/manifests/{reference}/head(existsImage)/responses/200`.
            ///
            /// HTTP response code: `200 ok`.
            case ok(Operations.existsImage.Output.Ok)
            /// The associated value of the enum case if `self` is `.ok`.
            ///
            /// - Throws: An error if `self` is not `.ok`.
            /// - SeeAlso: `.ok`.
            internal var ok: Operations.existsImage.Output.Ok {
                get throws {
                    switch self {
                    case let .ok(response):
                        return response
                    default:
                        try throwUnexpectedResponseStatus(
                            expectedStatus: "ok",
                            response: self
                        )
                    }
                }
            }
            internal struct NotFound: Sendable, Hashable {
                /// Creates a new `NotFound`.
                internal init() {}
            }
            /// Image could not be found in registry
            ///
            /// - Remark: Generated from `#/paths//{repository}/manifests/{reference}/head(existsImage)/responses/404`.
            ///
            /// HTTP response code: `404 notFound`.
            case notFound(Operations.existsImage.Output.NotFound)
            /// The associated value of the enum case if `self` is `.notFound`.
            ///
            /// - Throws: An error if `self` is not `.notFound`.
            /// - SeeAlso: `.notFound`.
            internal var notFound: Operations.existsImage.Output.NotFound {
                get throws {
                    switch self {
                    case let .notFound(response):
                        return response
                    default:
                        try throwUnexpectedResponseStatus(
                            expectedStatus: "notFound",
                            response: self
                        )
                    }
                }
            }
            /// Undocumented response.
            ///
            /// A response with a code that is not documented in the OpenAPI document.
            case undocumented(statusCode: Swift.Int, OpenAPIRuntime.UndocumentedPayload)
        }
    }
    /// Retrieve a blob from an image
    ///
    /// - Remark: HTTP `GET /{repository}/blobs/{digest}`.
    /// - Remark: Generated from `#/paths//{repository}/blobs/{digest}/get(getBlob)`.
    internal enum getBlob {
        internal static let id: Swift.String = "getBlob"
        internal struct Input: Sendable, Hashable {
            /// - Remark: Generated from `#/paths/{repository}/blobs/{digest}/GET/path`.
            internal struct Path: Sendable, Hashable {
                /// Namespace of the repository
                ///
                /// - Remark: Generated from `#/paths/{repository}/blobs/{digest}/GET/path/repository`.
                internal var repository: Swift.String
                /// The blob's digest for retrieval
                ///
                /// - Remark: Generated from `#/paths/{repository}/blobs/{digest}/GET/path/digest`.
                internal var digest: Swift.String
                /// Creates a new `Path`.
                ///
                /// - Parameters:
                ///   - repository: Namespace of the repository
                ///   - digest: The blob's digest for retrieval
                internal init(
                    repository: Swift.String,
                    digest: Swift.String
                ) {
                    self.repository = repository
                    self.digest = digest
                }
            }
            internal var path: Operations.getBlob.Input.Path
            /// Creates a new `Input`.
            ///
            /// - Parameters:
            ///   - path:
            internal init(path: Operations.getBlob.Input.Path) {
                self.path = path
            }
        }
        @frozen internal enum Output: Sendable, Hashable {
            internal struct Ok: Sendable, Hashable {
                /// Creates a new `Ok`.
                internal init() {}
            }
            /// Request blob for an image
            ///
            /// - Remark: Generated from `#/paths//{repository}/blobs/{digest}/get(getBlob)/responses/200`.
            ///
            /// HTTP response code: `200 ok`.
            case ok(Operations.getBlob.Output.Ok)
            /// The associated value of the enum case if `self` is `.ok`.
            ///
            /// - Throws: An error if `self` is not `.ok`.
            /// - SeeAlso: `.ok`.
            internal var ok: Operations.getBlob.Output.Ok {
                get throws {
                    switch self {
                    case let .ok(response):
                        return response
                    default:
                        try throwUnexpectedResponseStatus(
                            expectedStatus: "ok",
                            response: self
                        )
                    }
                }
            }
            internal struct NotFound: Sendable, Hashable {
                /// Creates a new `NotFound`.
                internal init() {}
            }
            /// Image blob not found
            ///
            /// - Remark: Generated from `#/paths//{repository}/blobs/{digest}/get(getBlob)/responses/404`.
            ///
            /// HTTP response code: `404 notFound`.
            case notFound(Operations.getBlob.Output.NotFound)
            /// The associated value of the enum case if `self` is `.notFound`.
            ///
            /// - Throws: An error if `self` is not `.notFound`.
            /// - SeeAlso: `.notFound`.
            internal var notFound: Operations.getBlob.Output.NotFound {
                get throws {
                    switch self {
                    case let .notFound(response):
                        return response
                    default:
                        try throwUnexpectedResponseStatus(
                            expectedStatus: "notFound",
                            response: self
                        )
                    }
                }
            }
            /// Undocumented response.
            ///
            /// A response with a code that is not documented in the OpenAPI document.
            case undocumented(statusCode: Swift.Int, OpenAPIRuntime.UndocumentedPayload)
        }
    }
    /// Check if a blob exists in the registry
    ///
    /// - Remark: HTTP `HEAD /{repository}/blobs/{digest}`.
    /// - Remark: Generated from `#/paths//{repository}/blobs/{digest}/head(existsBlob)`.
    internal enum existsBlob {
        internal static let id: Swift.String = "existsBlob"
        internal struct Input: Sendable, Hashable {
            /// - Remark: Generated from `#/paths/{repository}/blobs/{digest}/HEAD/path`.
            internal struct Path: Sendable, Hashable {
                /// Namespace of the repository
                ///
                /// - Remark: Generated from `#/paths/{repository}/blobs/{digest}/HEAD/path/repository`.
                internal var repository: Swift.String
                /// The blob's digest for checking
                ///
                /// - Remark: Generated from `#/paths/{repository}/blobs/{digest}/HEAD/path/digest`.
                internal var digest: Swift.String
                /// Creates a new `Path`.
                ///
                /// - Parameters:
                ///   - repository: Namespace of the repository
                ///   - digest: The blob's digest for checking
                internal init(
                    repository: Swift.String,
                    digest: Swift.String
                ) {
                    self.repository = repository
                    self.digest = digest
                }
            }
            internal var path: Operations.existsBlob.Input.Path
            /// Creates a new `Input`.
            ///
            /// - Parameters:
            ///   - path:
            internal init(path: Operations.existsBlob.Input.Path) {
                self.path = path
            }
        }
        @frozen internal enum Output: Sendable, Hashable {
            internal struct Ok: Sendable, Hashable {
                /// Creates a new `Ok`.
                internal init() {}
            }
            /// Blob exists on the registry
            ///
            /// - Remark: Generated from `#/paths//{repository}/blobs/{digest}/head(existsBlob)/responses/200`.
            ///
            /// HTTP response code: `200 ok`.
            case ok(Operations.existsBlob.Output.Ok)
            /// The associated value of the enum case if `self` is `.ok`.
            ///
            /// - Throws: An error if `self` is not `.ok`.
            /// - SeeAlso: `.ok`.
            internal var ok: Operations.existsBlob.Output.Ok {
                get throws {
                    switch self {
                    case let .ok(response):
                        return response
                    default:
                        try throwUnexpectedResponseStatus(
                            expectedStatus: "ok",
                            response: self
                        )
                    }
                }
            }
            internal struct NotFound: Sendable, Hashable {
                /// Creates a new `NotFound`.
                internal init() {}
            }
            /// Blob could not be found in registry
            ///
            /// - Remark: Generated from `#/paths//{repository}/blobs/{digest}/head(existsBlob)/responses/404`.
            ///
            /// HTTP response code: `404 notFound`.
            case notFound(Operations.existsBlob.Output.NotFound)
            /// The associated value of the enum case if `self` is `.notFound`.
            ///
            /// - Throws: An error if `self` is not `.notFound`.
            /// - SeeAlso: `.notFound`.
            internal var notFound: Operations.existsBlob.Output.NotFound {
                get throws {
                    switch self {
                    case let .notFound(response):
                        return response
                    default:
                        try throwUnexpectedResponseStatus(
                            expectedStatus: "notFound",
                            response: self
                        )
                    }
                }
            }
            /// Undocumented response.
            ///
            /// A response with a code that is not documented in the OpenAPI document.
            case undocumented(statusCode: Swift.Int, OpenAPIRuntime.UndocumentedPayload)
        }
    }
}
