import Foundation

struct ProductAPIService {
    let apiClient: APIClientProtocol

    func featuredProducts() async throws -> [ProductDTO] {
        try await apiClient.send(Endpoint(path: "products/featured"), responseType: [ProductDTO].self)
    }

    func products(categoryID: Int?) async throws -> [ProductDTO] {
        let queryItems = categoryID.map { [URLQueryItem(name: "category_id", value: "\($0)")] } ?? []
        return try await apiClient.send(Endpoint(path: "products", queryItems: queryItems), responseType: [ProductDTO].self)
    }
}
