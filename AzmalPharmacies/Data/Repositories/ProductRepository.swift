import Foundation

struct ProductRepository: ProductRepositoryProtocol {
    private let service: ProductAPIService

    init(apiClient: APIClientProtocol) {
        self.service = ProductAPIService(apiClient: apiClient)
    }

    func featuredProducts() async throws -> [Product] {
        try await service.featuredProducts().map(ProductMapper.map)
    }

    func products(categoryID: Int?) async throws -> [Product] {
        try await service.products(categoryID: categoryID).map(ProductMapper.map)
    }

    func product(id: Int) async throws -> Product {
        Product(id: id, name: "Product", description: "", price: 0, imageURL: nil, isAvailable: true, categoryID: nil)
    }

    func search(query: String) async throws -> [Product] {
        []
    }
}
