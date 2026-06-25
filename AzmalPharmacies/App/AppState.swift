import Foundation
import Observation

// MARK: – App Phase

/// Represents the three top-level navigation phases of the app.
enum AppPhase {
    /// Animated launch screen while the app resolves the initial state.
    case splash
    /// Shown once on a fresh install; skipped on every subsequent launch.
    case onboarding
    /// The main tab experience — available to both guests and authenticated users.
    case main
}

// MARK: – AppState

@Observable
final class AppState {
    // MARK: Navigation phase
    var phase: AppPhase = .splash

    // MARK: Auth sheet
    /// Set to `true` to present the `AuthView` fullscreen cover.
    /// Views that require authentication should write this flag rather than
    /// navigating directly to auth routes.
    var showAuthSheet: Bool = false

    // MARK: Tab bar
    var selectedTab: AppTab = .home
    var cartItemsCount: Int = 0
}

// MARK: – AppTab

enum AppTab: Hashable, CaseIterable {
    case home
    case offers
    case cart
    case orders
    case more

    var title: String {
        switch self {
        case .home:   String(localized: "tab.home")
        case .offers: String(localized: "tab.offers")
        case .cart:   String(localized: "tab.cart")
        case .orders: String(localized: "tab.orders")
        case .more:   String(localized: "tab.more")
        }
    }

    var systemImage: String {
        switch self {
        case .home:   "house"
        case .offers: "percent"
        case .cart:   "cart"
        case .orders: "doc.text"
        case .more:   "ellipsis.circle"
        }
    }

    /// Tabs that require the user to be authenticated before entering.
    static let protected: Set<AppTab> = [.cart, .orders, .more]
}
