import SwiftUI

struct FavoritesView: View {
    @Environment(AppRouter.self) private var router
    
    // Grid columns setup for 2 items per row
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // Navigation Bar
            AppNavigationBar(
                title: String(localized: "Favorites"),
                showBackButton: true,
                backAction: { router.pop() }
            )
            .background(AppColors.primary)
            
            // Content
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(Product.mockProducts) { product in
                        ProductCell(
                            title: product.name,
                            imageURL: product.imageURL?.absoluteString,
                            currentPrice: "EGP \(NSDecimalNumber(decimal: product.price).intValue)",
                            originalPrice: nil,
                            badge: .none,
                            isFavorite: true, // Assuming all in favorites are favorited
                            cartQuantity: 0,
                            onFavoriteToggle: {
                                // Toggle action
                            },
                            onAdd: {
                                // Add to cart action
                            },
                            onRemove: {
                                // Remove from cart action
                            }
                        )
                    }
                }
                .padding(.horizontal, AppSpacing.medium)
                .padding(.vertical, 24)
            }
        }
        .background(AppColors.background)
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    FavoritesView()
        .environment(AppRouter())
}
