import SwiftUI

struct OffersView: View {
    @State private var viewModel = OffersViewModel()
    
    // Grid columns setup for 2 items per row
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // Custom Header
            AppNavigationBar(
                title: "Offers",
                showBackButton: false,
                searchBinding: $viewModel.searchText,
                searchPlaceholder: "Search your Medicine & Healthcare Products",
                trailingContent: {
                HStack(spacing: 8) {
                    Button(action: {
                        // Filter action
                    }) {
                        Image(systemName: "line.3.horizontal.decrease.circle.fill")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundColor(.white)
                    }
                    
                    Button(action: {
                        // Sort action
                    }) {
                        Image(systemName: "arrow.up.arrow.down.circle.fill")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundColor(.white)
                    }
                }
            })
            .background(AppColors.primary)
            
            // Content
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(
                        Array(zip(viewModel.filteredProducts.indices, viewModel.filteredProducts)),
                        id: \.0
                    ) { index, product in
                        ProductCell(
                            title: product.name,
                            imageURL: product.imageURL?.absoluteString,
                            currentPrice: "EGP \(product.price)",
                            originalPrice: "EGP \(product.price + 200)",
                            badge: viewModel.getBadge(for: index),
                            isFavorite: false,
                            cartQuantity: viewModel.cart[product.id] ?? 0,
                            onFavoriteToggle: {
                                viewModel.toggleFavorite(productID: product.id)
                            },
                            onAdd: {
                                viewModel.addToCart(productID: product.id)
                            },
                            onRemove: {
                                viewModel.removeFromCart(productID: product.id)
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
//        .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    OffersView()
}
