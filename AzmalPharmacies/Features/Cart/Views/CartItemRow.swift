import SwiftUI

struct CartItemRow: View {
    let item: CartItem
    @State private var quantity: Int

    init(item: CartItem) {
        self.item = item
        self._quantity = State(initialValue: item.quantity)
    }

    var body: some View {
        HStack(spacing: AppSpacing.medium) {
            Image(systemName: "pills")
                .foregroundStyle(AppColors.primary)
                .frame(width: 48, height: 48)
                .background(AppColors.primary.opacity(0.08))
                .clipShape(RoundedRectangle(cornerRadius: AppRadius.medium))

            VStack(alignment: .leading) {
                Text(item.product.name)
                    .font(AppTypography.headline)
                PriceLabel(amount: item.product.price)
            }
            Spacer()
            QuantityStepper(quantity: $quantity)
        }
    }
}
