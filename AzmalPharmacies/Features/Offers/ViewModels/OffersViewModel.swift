import Foundation
import Observation

@Observable
final class OffersViewModel {
    var searchText: String = ""
    var products: [Product] = []
    
    // Simulate a cart for the UI demonstration
    var cart: [Int: Int] = [:] // Product ID to Quantity
    
    var filteredProducts: [Product] {
        if searchText.trimmingCharacters(in: .whitespaces).isEmpty {
            return products
        } else {
            return products.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    init() {
        // Load mock products
        // We will duplicate some mock products to fill the grid like in the design
        var allProducts = Product.mockProducts
        if allProducts.count < 8 {
            allProducts.append(contentsOf: Product.mockProducts)
            allProducts.append(contentsOf: Product.mockProducts)
        }
        self.products = allProducts
    }
    
    func getBadge(for index: Int) -> ProductBadge {
        // Alternate badges for demonstration
        if index % 2 == 0 {
            return .discount("20% Discount")
        } else {
            return .discount("Buy 1 Get 1 Free")
        }
    }
    
    func addToCart(productID: Int) {
        let current = cart[productID, default: 0]
        cart[productID] = current + 1
    }
    
    func removeFromCart(productID: Int) {
        let current = cart[productID, default: 0]
        if current > 1 {
            cart[productID] = current - 1
        } else {
            cart.removeValue(forKey: productID)
        }
    }
    
    func toggleFavorite(productID: Int) {
        // Just for demo, you could add it to a favorites list here
    }
}
