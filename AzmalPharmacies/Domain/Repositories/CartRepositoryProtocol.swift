import Foundation

protocol CartRepositoryProtocol {
    func cartItems() async throws -> [CartItem]
    func add(productID: Int, quantity: Int) async throws
    func update(itemID: Int, quantity: Int) async throws
    func remove(itemID: Int) async throws
}
