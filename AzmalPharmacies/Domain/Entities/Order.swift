import Foundation

struct Order: Identifiable, Equatable {
    let id: Int
    var number: String
    var status: OrderStatus
    var total: Decimal
    var createdAt: Date
    var items: [CartItem]
}

enum OrderStatus: String, CaseIterable {
    case pending
    case confirmed
    case preparing
    case outForDelivery
    case delivered
    case cancelled
}
