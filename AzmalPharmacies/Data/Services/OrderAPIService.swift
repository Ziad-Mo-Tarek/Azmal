import Foundation

struct OrderAPIService {
    let apiClient: APIClientProtocol
    let tokenProvider: TokenProvider
}
