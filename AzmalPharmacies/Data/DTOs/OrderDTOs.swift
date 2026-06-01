import Foundation

struct OrderDTO: Decodable {
    let id: Int
    let number: String
    let status: String
    let total: Decimal
    let createdAt: Date?
}
