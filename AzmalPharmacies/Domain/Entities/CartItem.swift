import Foundation

struct CartItem: Identifiable, Equatable {
    let id: Int
    var product: Product
    var quantity: Int

    var subtotal: Decimal {
        product.price * Decimal(quantity)
    }
}
