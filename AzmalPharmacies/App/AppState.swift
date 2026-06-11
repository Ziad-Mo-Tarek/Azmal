import Foundation
import Observation

@Observable
final class AppState {
    var selectedTab: AppTab = .home
    var isAuthenticated = false
    var cartItemsCount = 0
    var isSplashFinished = false
}

enum AppTab: Hashable, CaseIterable {
    case home
    case categories
    case cart
    case orders
    case profile

    var title: String {
        switch self {
        case .home: "Home"
        case .categories: "Categories"
        case .cart: "Cart"
        case .orders: "Orders"
        case .profile: "Profile"
        }
    }

    var systemImage: String {
        switch self {
        case .home: "house"
        case .categories: "square.grid.2x2"
        case .cart: "cart"
        case .orders: "doc.text"
        case .profile: "person"
        }
    }
}
