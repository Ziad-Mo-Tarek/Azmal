import SwiftUI

struct SecondaryButton: View {
    let title: String
    var systemImage: String?
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(/*spacing: AppSpacing.small*/) {
                if let systemImage {
                    Image(systemName: systemImage)
                }
                Text(title)
//                    .font(AppTypography.headline)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
        }
        .buttonStyle(.plain)
//        .foregroundStyle(AppColors.primary)
//        .background(AppColors.primary.opacity(0.08))
//        .clipShape(RoundedRectangle(cornerRadius: AppRadius.medium))
    }
}
