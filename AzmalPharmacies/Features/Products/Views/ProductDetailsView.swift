import SwiftUI

struct ProductDetailsView: View {
    let productID: Int
    @State private var quantity = 1
    @State private var searchText = ""
    @Environment(AppState.self) private var appState
    @Environment(AppRouter.self) private var router

    private var product: Product {
        Product.mockProducts.first { $0.id == productID } ?? Product.mockProducts[0]
    }

    var body: some View {
        VStack(spacing: 0) {
            AppNavigationBar(
                title: product.name,
                showBackButton: true,
                backAction: { router.pop() },
                onSearchSubmit: {}
            )
            .background(AppColors.primary)
            
            ScrollView {
                VStack(spacing: AppSpacing.large) {
                    
                    // Main Info Card
                    ProductDetailCard {
                        VStack(alignment: .leading, spacing: AppSpacing.medium) {
                            ZStack(alignment: .topTrailing) {
                                // Image Gallery
                                ProductImageGallery(imageUrls: [
                                    product.imageURL?.absoluteString ?? AppConstants.randomeImage,
                                    AppConstants.randomeImage,
                                    AppConstants.randomeImage
                                ])
                                
                                Button(action: {}) {
                                    Image(systemName: "heart")
                                        .font(.system(size: 24))
                                        .foregroundColor(AppColors.primary)
                                }
                                .padding()
                            }
                            
                            Text("In Stock")
                                .appTextStyle(.bodySmall, color: Color(hex: "#FFC107") ?? .yellow, weight: .bold)
                            
                            Text(product.name)
                                .appTextStyle(.headingSmall, color: .black, weight: .bold)
                            
                            Text("By CeraVe") // Hardcoded for now per design
                                .appTextStyle(.bodySmall, color: AppColors.primary, weight: .semibold)
                            
                            HStack {
                                HStack(spacing: 4) {
                                    Image(systemName: "circle.fill") // Placeholder for coin
                                        .foregroundColor(Color(hex: "#FFD700") ?? .yellow)
                                        .font(.system(size: 14))
                                    Text("EGP \(NSDecimalNumber(decimal: product.price).intValue)")
                                        .appTextStyle(.headingSmall, color: .black, weight: .bold)
                                }
                                
                                Spacer()
                                
                                PillQuantityStepper(quantity: $quantity)
                            }
                            .padding(.top, AppSpacing.small)
                        }
                    }
                    
                    // Description Card
                    ProductDetailCard {
                        VStack(alignment: .leading, spacing: AppSpacing.medium) {
                            Text("Description")
                                .appTextStyle(.bodyMedium, color: .black, weight: .bold)
                            
                            Text(product.description)
                                .appTextStyle(.bodySmall, color: AppColors.textSecondary)
                                .lineSpacing(4)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    // Related Products Card
                    
                        VStack(alignment: .leading, spacing: AppSpacing.medium) {
                            Text("Related Products")
                                .appTextStyle(.bodyMedium, color: .black, weight: .bold)
                                .padding([.top, .leading], AppSpacing.large)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: AppSpacing.medium) {
                                    ForEach(0..<4) { _ in
                                        ProductCell(
                                            title: "Cerave daily moisturizing lotion for normal to dry ski...",
                                            imageURL: nil,
                                            currentPrice: "EGP 1000",
                                            originalPrice: nil,
                                            badge: .none,
                                            isFavorite: false,
                                            cartQuantity: 0,
                                            onFavoriteToggle: {},
                                            onAdd: {},
                                            onRemove: {},
                                            fixedWidth: 164
                                        )
                                        .onTapGesture {
                                            router.push(.productDetails(id: 1))
                                        }
                                    }
                                }
                                .padding(AppSpacing.large)
                            }
                        }
                        .background(AppColors.surface)
                        .clipShape(RoundedRectangle(cornerRadius: AppRadius.large))
                    
                }
                .padding(AppSpacing.large)
            }
            .background(AppColors.background)
            
            // Sticky Bottom Bar
            VStack(spacing: 0) {
                PrimaryButton(title: "ADD TO CART") {
                    appState.cartItemsCount += quantity
                }
                .padding(AppSpacing.large)
                .background(AppColors.surface)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .ignoresSafeArea(.keyboard)
    }
}


#Preview {
    ProductDetailsView(productID: 1)
        .environment(AppRouter())
        .environment(AppState())
}
