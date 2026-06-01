import Foundation

enum APIError: LocalizedError, Equatable {
    case invalidURL
    case invalidResponse
    case requestFailed(statusCode: Int, message: String?)
    case decodingFailed(String)
    case transport(String)
    case unauthorized

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            "The request URL is invalid."
        case .invalidResponse:
            "The server response is invalid."
        case .requestFailed(let statusCode, let message):
            message ?? "The request failed with status code \(statusCode)."
        case .decodingFailed(let message):
            "Unable to decode response: \(message)"
        case .transport(let message):
            message
        case .unauthorized:
            "Your session has expired."
        }
    }
}
