import SwiftUI

struct ProductCard: View {
    let product: Product
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: AppSpacing.small) {
                RoundedRectangle(cornerRadius: AppRadius.medium)
                    .fill(AppColors.primary.opacity(0.08))
                    .frame(height: 92)
                    .overlay(Image(systemName: "pills").foregroundStyle(AppColors.primary))

                Text(product.name)
                    .font(AppTypography.headline)
                    .foregroundStyle(AppColors.textPrimary)
                    .lineLimit(2)

                Text(product.description.isEmpty ? "Medicine" : product.description)
                    .font(AppTypography.caption)
                    .foregroundStyle(AppColors.textSecondary)
                    .lineLimit(1)

                PriceLabel(amount: product.price)
            }
            .padding(AppSpacing.medium)
            .background(AppColors.surface)
            .clipShape(RoundedRectangle(cornerRadius: AppRadius.medium))
        }
        .buttonStyle(.plain)
    }
}
