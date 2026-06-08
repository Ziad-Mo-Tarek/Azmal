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
            .environment(homeRouter)
            .tabItem { Label(AppTab.home.title, systemImage: AppTab.home.systemImage) }
            .tag(AppTab.home)

            NavigationStack(path: $categoriesRouter.path) {
                CategoriesView()
                    .withAppRouter()
            }
            .environment(categoriesRouter)
            .tabItem { Label(AppTab.categories.title, systemImage: AppTab.categories.systemImage) }
            .tag(AppTab.categories)

            NavigationStack(path: $cartRouter.path) {
                CartView()
                    .withAppRouter()
            }
            .environment(cartRouter)
            .tabItem { Label(AppTab.cart.title, systemImage: AppTab.cart.systemImage) }
            .badge(appState.cartItemsCount)
            .tag(AppTab.cart)

            NavigationStack(path: $ordersRouter.path) {
                OrdersView()
                    .withAppRouter()
            }
            .environment(ordersRouter)
            .tabItem { Label(AppTab.orders.title, systemImage: AppTab.orders.systemImage) }
            .tag(AppTab.orders)

            NavigationStack(path: $profileRouter.path) {
                ProfileView()
                    .withAppRouter()
            }
            .environment(profileRouter)
            .tabItem { Label(AppTab.profile.title, systemImage: AppTab.profile.systemImage) }
            .tag(AppTab.profile)
        }
        .tint(AppColors.primary)
    }
}
