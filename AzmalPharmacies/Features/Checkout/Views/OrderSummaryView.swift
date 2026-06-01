import SwiftUI

struct OrderSummaryView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            HStack {
                Text("Subtotal")
                Spacer()
                PriceLabel(amount: 120)
            }
            HStack {
                Text("Delivery")
                Spacer()
                PriceLabel(amount: 20)
            }
            Divider()
            HStack {
                Text("Total")
                    .font(AppTypography.headline)
                Spacer()
                PriceLabel(amount: 140)
            }
        }
    }
}
