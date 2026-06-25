import SwiftUI

struct MainTabView: View {
    @Environment(AppState.self) private var appState
    @Environment(DependencyContainer.self) private var dependencies

    @State private var homeRouter       = AppRouter()
    @State private var categoriesRouter = AppRouter()
    @State private var cartRouter       = AppRouter()
    @State private var ordersRouter     = AppRouter()
    @State private var profileRouter    = AppRouter()

    var body: some View {
        @Bindable var appState = appState

        TabView(selection: $appState.selectedTab) {
            // ── Home (always accessible) ─────────────────────────────────
            NavigationStack(path: $homeRouter.path) {
                HomeView(viewModel: HomeViewModel(productRepository: DependencyContainer.live.productRepository))
                    .withAppRouter()
            }
            .toolbar(.hidden, for: .navigationBar)
            .environment(homeRouter)
            .tabItem { Label(AppTab.home.title, systemImage: AppTab.home.systemImage) }
            .tag(AppTab.home)

            // ── Offers (always accessible) ───────────────────────────────
            NavigationStack(path: $categoriesRouter.path) {
                OffersView()
                    .withAppRouter()
            }
            .toolbar(.hidden, for: .navigationBar)
            .environment(categoriesRouter)
            .tabItem { Label(AppTab.offers.title, systemImage: AppTab.offers.systemImage) }
            .tag(AppTab.offers)

            // ── Cart (protected) ─────────────────────────────────────────
            NavigationStack(path: $cartRouter.path) {
                CartView()
                    .withAppRouter()
            }
            .toolbar(.hidden, for: .navigationBar)
            .environment(cartRouter)
            .tabItem { Label(AppTab.cart.title, systemImage: AppTab.cart.systemImage) }
            .badge(appState.cartItemsCount)
            .tag(AppTab.cart)

            // ── Orders (protected) ───────────────────────────────────────
            NavigationStack(path: $ordersRouter.path) {
                OrdersView()
                    .withAppRouter()
            }
            .toolbar(.hidden, for: .navigationBar)
            .environment(ordersRouter)
            .tabItem { Label(AppTab.orders.title, systemImage: AppTab.orders.systemImage) }
            .tag(AppTab.orders)

            // ── More (protected) ─────────────────────────────────────────
            NavigationStack(path: $profileRouter.path) {
                MoreView()
                    .withAppRouter()
            }
            .toolbar(.hidden, for: .navigationBar)
            .environment(profileRouter)
            .tabItem { Label(AppTab.more.title, systemImage: AppTab.more.systemImage) }
            .tag(AppTab.more)
        }
        .tint(AppColors.primary)
        // ── Auth gate ────────────────────────────────────────────────────
        // Intercept any tap on a protected tab while the user is a guest.
        // Snap back to Home and raise the auth sheet instead.
        .onChange(of: appState.selectedTab) { _, newTab in
            guard AppTab.protected.contains(newTab),
                  !dependencies.authSession.isAuthenticated
            else { return }

            appState.selectedTab = .home
            appState.showAuthSheet = true
        }
    }
}
