import Foundation

protocol ProductRepositoryProtocol {
    func featuredProducts() async throws -> [Product]
    func products(categoryID: Int?) async throws -> [Product]
    func product(id: Int) async throws -> Product
    func search(query: String) async throws -> [Product]
}
