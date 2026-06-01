import Foundation

struct CartRepository: CartRepositoryProtocol {
    private let service: CartAPIService

    init(apiClient: APIClientProtocol, tokenProvider: TokenProvider) {
        self.service = CartAPIService(apiClient: apiClient, tokenProvider: tokenProvider)
    }

    func cartItems() async throws -> [CartItem] {
        []
    }

    func add(productID: Int, quantity: Int) async throws {}
    func update(itemID: Int, quantity: Int) async throws {}
    func remove(itemID: Int) async throws {}
}
