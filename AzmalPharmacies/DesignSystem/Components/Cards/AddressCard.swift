import SwiftUI

struct AddressCard: View {
    let address: Address

    var body: some View {
        HStack(alignment: .top/*, spacing: AppSpacing.medium*/) {
            Image(systemName: "mappin.and.ellipse")
//                .foregroundStyle(AppColors.primary)
            VStack(alignment: .leading/*, spacing: AppSpacing.xSmall*/) {
                Text(address.title)
//                    .font(AppTypography.headline)
                Text("\(address.street), \(address.city)")
//                    .font(AppTypography.body)
//                    .foregroundStyle(AppColors.textSecondary)
            }
            Spacer()
        }
//        .padding(AppSpacing.large)
//        .background(AppColors.surface)
//        .clipShape(RoundedRectangle(cornerRadius: AppRadius.medium))
    }
}
