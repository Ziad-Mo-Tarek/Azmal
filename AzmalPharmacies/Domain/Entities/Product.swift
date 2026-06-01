import Foundation

struct Product: Identifiable, Equatable {
    let id: Int
    var name: String
    var description: String
    var price: Decimal
    var imageURL: URL?
    var isAvailable: Bool
    var categoryID: Int?
}
