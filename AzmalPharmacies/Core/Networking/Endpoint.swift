import Foundation

struct Endpoint {
    var path: String
    var method: APIHTTPMethod
    var queryItems: [URLQueryItem]
    var headers: [String: String]
    var body: Data?

    init(
        path: String,
        method: APIHTTPMethod = .get,
        queryItems: [URLQueryItem] = [],
        headers: [String: String] = [:],
        body: Data? = nil
    ) {
        self.path = path
        self.method = method
        self.queryItems = queryItems
        self.headers = headers
        self.body = body
    }
}
