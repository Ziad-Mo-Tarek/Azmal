import SwiftUI

struct MainTabView: View {
    @Environment(AppState.self) private var appState

    @State private var homeRouter = AppRouter()
    @State private var categoriesRouter = AppRouter()
    @State private var cartRouter = AppRouter()
    @State private var ordersRouter = AppRouter()
    @State private var profileRouter = AppRouter()

    var body: some View {
        @Bindable var appState = appState

        TabView(selection: $appState.selectedTab) {
            NavigationStack(path: $homeRouter.path) {
                HomeView(viewModel: HomeViewModel(productRepository: DependencyContainer.live.productRepository))
                    .withAppRouter()
            }
            .toolbar(.hidden, for: .navigationBar)
            .environment(homeRouter)
            .tabItem { Label(AppTab.home.title, systemImage: AppTab.home.systemImage) }
            .tag(AppTab.home)

            NavigationStack(path: $categoriesRouter.path) {
                OffersView()
                    .withAppRouter()
            }
            .toolbar(.hidden, for: .navigationBar)
            .environment(categoriesRouter)
            .tabItem { Label(AppTab.offers.title, systemImage: AppTab.offers.systemImage) }
            .tag(AppTab.offers)

            NavigationStack(path: $cartRouter.path) {
                CartView()
                    .withAppRouter()
            }
            .toolbar(.hidden, for: .navigationBar)
            .environment(cartRouter)
            .tabItem { Label(AppTab.cart.title, systemImage: AppTab.cart.systemImage) }
            .badge(appState.cartItemsCount)
            .tag(AppTab.cart)

            NavigationStack(path: $ordersRouter.path) {
                OrdersView()
                    .withAppRouter()
            }
            .toolbar(.hidden, for: .navigationBar)
            .environment(ordersRouter)
            .tabItem { Label(AppTab.orders.title, systemImage: AppTab.orders.systemImage) }
            .tag(AppTab.orders)

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
    }
}
