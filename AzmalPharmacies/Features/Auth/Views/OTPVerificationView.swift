import SwiftUI

struct OTPVerificationView: View {
    let phone: String
    @State private var code = ""

    var body: some View {
        VStack(spacing: AppSpacing.large) {
            Text("Code sent to \(phone)")
                .font(AppTypography.body)
                .foregroundStyle(AppColors.textSecondary)
            OTPTextField(code: $code)
            PrimaryButton(title: "Verify", systemImage: "checkmark") {}
        }
        .appScreenPadding()
        .navigationTitle("Verification")
    }
}
