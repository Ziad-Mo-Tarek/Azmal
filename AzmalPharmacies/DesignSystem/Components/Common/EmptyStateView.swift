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
                .appTextStyle(.headingMedium, color: .appDark, weight: .medium)
                .multilineTextAlignment(.center)
            Text(message)
                .appTextStyle(.bodySmall, color: .gray, weight: .regular)
                .multilineTextAlignment(.center)
        }
        .padding(AppSpacing.xLarge)
    }
}
