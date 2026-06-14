import SwiftUI

struct PillQuantityStepper: View {
    @Binding var quantity: Int

    var body: some View {
        HStack(spacing: AppSpacing.medium) {
            Button {
                quantity = max(1, quantity - 1)
            } label: {
                Image(systemName: "minus")
                    .font(.system(size: 14, weight: .bold))
                    .frame(width: 32, height: 32)
                    .foregroundStyle(AppColors.primary)
            }
            .buttonStyle(.plain)

            Text(String(format: "%02d", quantity))
                .appTextStyle(.bodyMedium, color: AppColors.primary, weight: .bold)
                .frame(minWidth: 20)

            Button {
                quantity += 1
            } label: {
                Image(systemName: "plus")
                    .font(.system(size: 14, weight: .bold))
                    .frame(width: 32, height: 32)
                    .foregroundStyle(.white)
                    .background(AppColors.primary)
                    .clipShape(Circle())
            }
            .buttonStyle(.plain)
        }
        .padding(4)
        .background(AppColors.surface)
        .overlay(
            Capsule()
                .strokeBorder(AppColors.border.opacity(0.5), lineWidth: 1)
        )
        .clipShape(Capsule())
    }
}

#Preview {
    PillQuantityStepper(quantity: .constant(1))
}
