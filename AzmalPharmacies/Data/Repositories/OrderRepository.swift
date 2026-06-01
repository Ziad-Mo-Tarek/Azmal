import Foundation

struct OrderRepository: OrderRepositoryProtocol {
    private let service: OrderAPIService

    init(apiClient: APIClientProtocol, tokenProvider: TokenProvider) {
        self.service = OrderAPIService(apiClient: apiClient, tokenProvider: tokenProvider)
    }

    func orders() async throws -> [Order] {
        []
    }

    func order(id: Int) async throws -> Order {
        Order(id: id, number: "#\(id)", status: .pending, total: 0, createdAt: Date(), items: [])
    }

    func submitOrder(addressID: Int, paymentMethodID: Int) async throws -> Order {
        Order(id: 0, number: "#0", status: .pending, total: 0, createdAt: Date(), items: [])
    }
}
