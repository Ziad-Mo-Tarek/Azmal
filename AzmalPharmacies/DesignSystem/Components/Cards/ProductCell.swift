import SwiftUI

enum ProductBadge {
    case bestSeller
    case discount(String)
}

struct ProductCell: View {
    let title: String
    let imageURL: String?
    let currentPrice: String
    let originalPrice: String?
    let badge: ProductBadge?
    let isFavorite: Bool
    let cartQuantity: Int
    let onFavoriteToggle: () -> Void
    let onAdd: () -> Void
    let onRemove: () -> Void
    /// Pass a fixed width for horizontal scroll contexts (e.g. Home). Leave nil in LazyVGrid
    /// so the cell fills its column naturally.
    var fixedWidth: CGFloat? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Image and Badges Header
            ZStack(alignment: .topTrailing) {
                // Product Image Container
                ZStack(alignment: .bottomLeading) {
                    
                    ImageLoader(
                        urlString: imageURL ?? AppConstants.randomeImage,
                        contentMode: .fill
                    )
                    
                    // Discount Badge
                    if case let .discount(text) = badge {
                        Text(text)
                            .appTextStyle(.captionMedium, color: AppColors.white, weight: .semibold)
                            .padding(.horizontal, AppSpacing.small)
                            .padding(.vertical, AppSpacing.xSmall)
                            .background(Color.yellow) // Assuming yellow is used for discount
                            .customCornerRadius(AppRadius.small, corners: [.bottomRight, .topRight])
                            .offset(y: 10)
                    }
                }
                .frame(maxWidth: .infinity)
                
                // Favorite Button
                Button(action: onFavoriteToggle) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(AppColors.primary) // Red for heart
                        .font(.system(size: 16))
                }
                .padding([.top, .trailing], AppSpacing.small)
                
                // Best Seller Badge
                if case .bestSeller = badge {
                    HStack {
                        Text("Best Seller")
                            .appTextStyle(.captionMedium, color: AppColors.white, weight: .semibold)
                            .padding(.horizontal, AppSpacing.small)
                            .padding(.vertical, AppSpacing.xSmall)
                            .background(AppColors.primary)
                            .customCornerRadius(AppRadius.medium, corners: [.topLeft, .bottomRight])
                        Spacer()
                    }
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                // Title
                Text(title)
                    .appTextStyle(.bodySmall, color: .primaryApp)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                // Price
                HStack(spacing: AppSpacing.xSmall) {
                    Text(currentPrice)
                        .appTextStyle(.bodySemiboldTiny, color: .primaryApp)
                    
                    if let originalPrice = originalPrice {
                        Text(originalPrice)
                            .appTextStyle(.captionSmall, color: .appDark)
                            .strikethrough()
                    }
                }
                
                Spacer(minLength: 0)
                
                // Add To Cart Button
                HStack {
                    Spacer()
                    if cartQuantity > 0 {
                        HStack(spacing: 13) {
                            Button(action: onRemove) {
                                Image(systemName: "minus")
                                    .foregroundColor(AppColors.primary)
                                    .frame(width: 28, height: 28)
                            }
                            
                            Text(String(format: "%02d", cartQuantity))
                                .appTextStyle(.bodySemiboldTiny, color: .primaryApp)
                            
                            Button(action: onAdd) {
                                Image(systemName: "plus")
                                    .foregroundColor(.white)
                                    .frame(width: 28, height: 28)
                                    .background(.primaryApp)
                                    .clipShape(Circle())
                            }
                        }
                        .background(Color.white)
                        .clipShape(Capsule())
                        .shadow(color: .appDark.opacity(0.25), radius: 4, x: 0, y: 6)
                        
                    } else {
                        Button(action: onAdd) {
                            Text(LocalizedStringKey("Add To Cart"))
                                .appTextStyle(.bodySemiboldTiny, color: .appWhite)
                                .padding(.horizontal, 11)
                                .padding(.vertical, 5)
                                .background(AppColors.primary)
                                .clipShape(Capsule())
                        }
                    }
                }
            }
            .padding(.horizontal, AppSpacing.small)
            .padding(.bottom, AppSpacing.small)
            .padding(.top, AppSpacing.medium)
        }
        .frame(width: fixedWidth, height: fixedWidth != nil ? 208 : 220)
        .frame(maxWidth: fixedWidth == nil ? .infinity : nil)
        .background(AppColors.surface)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: .appDark.opacity(0.25), radius: 4, x: 0, y: 6)
    }
}

#Preview {
    ZStack {
        AppColors.background.ignoresSafeArea()
        
        ScrollView {
            VStack(spacing: 20) {
                // Normal
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
                    onRemove: {}
                )
                
                // Discount
                ProductCell(
                    title: "Cerave daily moisturizing lotion for normal to dry ski...",
                    imageURL: nil,
                    currentPrice: "EGP 800",
                    originalPrice: "EGP 1000",
                    badge: .discount("20% Discount"),
                    isFavorite: false,
                    cartQuantity: 2,
                    onFavoriteToggle: {},
                    onAdd: {},
                    onRemove: {}
                )
                
                // Best Seller
                ProductCell(
                    title: "Cerave daily moisturizing lotion for normal to dry ski...",
                    imageURL: nil,
                    currentPrice: "EGP 1000",
                    originalPrice: nil,
                    badge: .bestSeller,
                    isFavorite: true,
                    cartQuantity: 0,
                    onFavoriteToggle: {},
                    onAdd: {},
                    onRemove: {}
                )
            }
            .padding()
        }
    }
}
