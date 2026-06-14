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
    case offers
    case cart
    case orders
    case more

    var title: String {
        switch self {
        case .home: String(localized: "tab.home")
        case .offers: String(localized: "tab.offers")
        case .cart: String(localized: "tab.cart")
        case .orders: String(localized: "tab.orders")
        case .more: String(localized: "tab.more")
        }
    }

    var systemImage: String {
        switch self {
        case .home: "house"
        case .offers: "percent"
        case .cart: "cart"
        case .orders: "doc.text"
        case .more: "ellipsis.circle"
        }
    }
}
