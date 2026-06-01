import Foundation

protocol APIClientProtocol {
    func send<Response: Decodable>(_ endpoint: Endpoint, responseType: Response.Type) async throws -> Response
}

final class APIClient: APIClientProtocol {
    private let session: URLSession
    private let decoder: JSONDecoder
    private let requestBuilder: RequestBuilder

    init(
        baseURL: URL = AppEnvironment.current.baseURL,
        session: URLSession = .shared,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.session = session
        self.decoder = decoder
        self.requestBuilder = RequestBuilder(baseURL: baseURL)
    }

    func send<Response: Decodable>(_ endpoint: Endpoint, responseType: Response.Type = Response.self) async throws -> Response {
        let request = try requestBuilder.makeRequest(for: endpoint)

        do {
            let (data, response) = try await session.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                if httpResponse.statusCode == 401 {
                    throw APIError.unauthorized
                }
                throw APIError.requestFailed(statusCode: httpResponse.statusCode, message: String(data: data, encoding: .utf8))
            }

            do {
                return try decoder.decode(Response.self, from: data)
            } catch {
                throw APIError.decodingFailed(error.localizedDescription)
            }
        } catch let error as APIError {
            throw error
        } catch {
            throw APIError.transport(error.localizedDescription)
        }
    }
}
