import SwiftUI

struct PriceLabel: View {
    let amount: Decimal
    var currency = "EGP"

    var body: some View {
        Text("\(currency) \(NSDecimalNumber(decimal: amount).doubleValue, specifier: "%.2f")")
            .font(AppTypography.headline)
            .foregroundStyle(AppColors.primary)
    }
}
