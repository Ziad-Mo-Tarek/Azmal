import Foundation

protocol OrderRepositoryProtocol {
    func orders() async throws -> [Order]
    func order(id: Int) async throws -> Order
    func submitOrder(addressID: Int, paymentMethodID: Int) async throws -> Order
}
