import SwiftUI

struct EmptyStateView: View {
    let title: String
    let message: String
    var systemImage = "tray"

    var body: some View {
        VStack(spacing: AppSpacing.medium) {
            Image(systemName: systemImage)
                .font(.system(size: 36))
                .foregroundStyle(AppColors.primary)
            Text(title)
                .font(AppTypography.title)
            Text(message)
                .font(AppTypography.body)
                .foregroundStyle(AppColors.textSecondary)
                .multilineTextAlignment(.center)
        }
        .padding(AppSpacing.xLarge)
    }
}
