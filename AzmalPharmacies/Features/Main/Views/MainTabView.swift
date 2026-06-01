import SwiftUI

struct MainTabView: View {
    @Environment(AppState.self) private var appState

    var body: some View {
        @Bindable var appState = appState

        TabView(selection: $appState.selectedTab) {
            HomeView()
                .tabItem { Label(AppTab.home.title, systemImage: AppTab.home.systemImage) }
                .tag(AppTab.home)

            CategoriesView()
                .tabItem { Label(AppTab.categories.title, systemImage: AppTab.categories.systemImage) }
                .tag(AppTab.categories)

            CartView()
                .tabItem { Label(AppTab.cart.title, systemImage: AppTab.cart.systemImage) }
                .badge(appState.cartItemsCount)
                .tag(AppTab.cart)

            OrdersView()
                .tabItem { Label(AppTab.orders.title, systemImage: AppTab.orders.systemImage) }
                .tag(AppTab.orders)

            ProfileView()
                .tabItem { Label(AppTab.profile.title, systemImage: AppTab.profile.systemImage) }
                .tag(AppTab.profile)
        }
        .tint(AppColors.primary)
    }
}
