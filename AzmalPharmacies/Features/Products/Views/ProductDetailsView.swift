import SwiftUI

struct ProductDetailsView: View {
    let productID: Int
    @State private var quantity = 1
    @Environment(AppState.self) private var appState
    @Environment(AppRouter.self) private var router

    private var product: Product {
        Product.mockProducts.first { $0.id == productID } ?? Product.mockProducts[0]
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppSpacing.large) {
                RoundedRectangle(cornerRadius: AppRadius.large)
                    .fill(AppColors.primary.opacity(0.08))
                    .frame(height: 220)
                    .overlay(Image(systemName: "pills.fill").font(.system(size: 64)).foregroundStyle(AppColors.primary))

                Text(product.name)
                    .font(AppTypography.largeTitle)
                Text(product.description)
                    .font(AppTypography.body)
                    .foregroundStyle(AppColors.textSecondary)
                PriceLabel(amount: product.price)
                QuantityStepper(quantity: $quantity)

                PrimaryButton(title: "Add to Cart", systemImage: "cart.badge.plus") {
                    appState.cartItemsCount += quantity
                }

                SecondaryButton(title: "Checkout", systemImage: "creditcard") {
                    router.push(.checkout)
                }
            }
            .appScreenPadding()
            .padding(.vertical, AppSpacing.large)
        }
        .background(AppColors.background)
        .navigationTitle("Product Details")
    }
}
