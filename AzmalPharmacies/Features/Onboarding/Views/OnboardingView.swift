import SwiftUI

struct OnboardingView: View {
    var body: some View {
        VStack(spacing: AppSpacing.large) {
            Image(systemName: "cross.case.fill")
                .font(.system(size: 72))
                .foregroundStyle(AppColors.primary)
            Text("Azmal Pharmacies")
                .font(AppTypography.largeTitle)
            Text("Order medicines, upload prescriptions, and track delivery.")
                .font(AppTypography.body)
                .foregroundStyle(AppColors.textSecondary)
                .multilineTextAlignment(.center)
        }
        .appScreenPadding()
    }
}
