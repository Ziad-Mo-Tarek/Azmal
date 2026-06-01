import SwiftUI

struct OrderCard: View {
    let order: Order

    var body: some View {
        VStack(alignment: .leading/*, spacing: AppSpacing.small*/) {
            HStack {
                Text(order.number)
//                    .font(AppTypography.headline)
                Spacer()
                BadgeView(text: order.status.rawValue.capitalized/*, tint: AppColors.primary*/)
            }
            PriceLabel(amount: order.total)
        }
//        .padding(AppSpacing.large)
//        .background(AppColors.surface)
//        .clipShape(RoundedRectangle(cornerRadius: AppRadius.medium))
    }
}
