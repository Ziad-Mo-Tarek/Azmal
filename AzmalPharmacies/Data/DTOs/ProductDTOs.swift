import Foundation

struct ProductDTO: Decodable {
    let id: Int
    let name: String
    let description: String?
    let price: Decimal
    let image: String?
    let available: Bool?
    let categoryId: Int?
}

struct CategoryDTO: Decodable {
    let id: Int
    let name: String
    let image: String?
}
