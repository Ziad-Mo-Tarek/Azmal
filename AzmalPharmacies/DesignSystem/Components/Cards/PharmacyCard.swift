import SwiftUI

struct PharmacyCard: View {
    let pharmacy: Pharmacy

    var body: some View {
        HStack(spacing: AppSpacing.medium) {
            Image(systemName: "cross.case.fill")
                .foregroundStyle(.white)
                .frame(width: 44, height: 44)
                .background(AppColors.primary)
                .clipShape(RoundedRectangle(cornerRadius: AppRadius.medium))

            VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                Text(pharmacy.name)
                    .font(AppTypography.headline)
                Text(pharmacy.address)
                    .font(AppTypography.caption)
                    .foregroundStyle(AppColors.textSecondary)
                    .lineLimit(2)
            }
            Spacer()
            if let distanceText = pharmacy.distanceText {
                Text(distanceText)
                    .font(AppTypography.caption)
                    .foregroundStyle(AppColors.primary)
            }
        }
        .padding(AppSpacing.large)
        .background(AppColors.surface)
        .clipShape(RoundedRectangle(cornerRadius: AppRadius.medium))
    }
}
