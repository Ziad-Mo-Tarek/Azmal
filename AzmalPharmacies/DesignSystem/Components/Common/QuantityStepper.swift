import SwiftUI

struct QuantityStepper: View {
    @Binding var quantity: Int

    var body: some View {
        HStack(spacing: AppSpacing.medium) {
            stepButton(systemImage: "minus") {
                quantity = max(1, quantity - 1)
            }
            Text("\(quantity)")
                .font(AppTypography.headline)
                .frame(minWidth: 24)
            stepButton(systemImage: "plus") {
                quantity += 1
            }
        }
    }

    private func stepButton(systemImage: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .frame(width: 32, height: 32)
                .background(AppColors.primary.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: AppRadius.small))
        }
        .buttonStyle(.plain)
        .foregroundStyle(AppColors.primary)
    }
}
