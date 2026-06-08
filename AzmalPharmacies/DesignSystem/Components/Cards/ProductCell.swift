import SwiftUI

struct CustomCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

extension View {
    func customCornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(CustomCorner(radius: radius, corners: corners))
    }
}

enum ProductBadge {
    case bestSeller
    case discount(String)
}

struct ProductCell: View {
    let title: String
    let imageURL: URL?
    let currentPrice: String
    let originalPrice: String?
    let badge: ProductBadge?
    let isFavorite: Bool
    let onFavoriteToggle: () -> Void
    let onAddToCart: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Image and Badges Header
            ZStack(alignment: .topTrailing) {
                // Product Image Container
                ZStack(alignment: .bottomLeading) {
                    
                    ImageLoader(
                        urlString: imageURL?.absoluteString ?? AppConstants.randomeImage,
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
//                    .lineLimit(2)
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
                    Button(action: onAddToCart) {
                        Text(LocalizedStringKey("Add To Cart"))
                            .appTextStyle(.bodySemiboldTiny, color: .appWhite)
                            .padding(.horizontal, 11)
                            .padding(.vertical, 5)
                            .background(AppColors.primary)
                            .clipShape(Capsule())
                    }
                }
            }
            .padding(.horizontal, AppSpacing.small)
            .padding(.bottom, AppSpacing.small)
            .padding(.top, AppSpacing.medium)
        }
        .frame(width: 164, height: 208)
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
                    onFavoriteToggle: {},
                    onAddToCart: {}
                )
                
                // Discount
                ProductCell(
                    title: "Cerave daily moisturizing lotion for normal to dry ski...",
                    imageURL: nil,
                    currentPrice: "EGP 800",
                    originalPrice: "EGP 1000",
                    badge: .discount("20% Discount"),
                    isFavorite: false,
                    onFavoriteToggle: {},
                    onAddToCart: {}
                )
                
                // Best Seller
                ProductCell(
                    title: "Cerave daily moisturizing lotion for normal to dry ski...",
                    imageURL: nil,
                    currentPrice: "EGP 1000",
                    originalPrice: nil,
                    badge: .bestSeller,
                    isFavorite: true,
                    onFavoriteToggle: {},
                    onAddToCart: {}
                )
            }
            .padding()
        }
    }
}
