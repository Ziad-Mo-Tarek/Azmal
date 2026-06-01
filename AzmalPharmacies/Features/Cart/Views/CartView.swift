import SwiftUI

struct CartView: View {
    @Environment(AppRouter.self) private var router

    var body: some View {
        VStack(spacing: AppSpacing.large) {
            EmptyStateView(title: "Your cart is empty", message: "Add medicines or upload a prescription to start an order.", systemImage: "cart")
            PrimaryButton(title: "Go to Checkout", systemImage: "creditcard") {
                router.push(.checkout)
            }
            .padding(.horizontal, AppSpacing.large)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppColors.background)
        .navigationTitle("Cart")
    }
}
