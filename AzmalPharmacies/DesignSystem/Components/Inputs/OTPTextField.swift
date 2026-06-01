import SwiftUI

struct OTPTextField: View {
    @Binding var code: String

    var body: some View {
        TextField("Code", text: $code)
            .keyboardType(.numberPad)
            .multilineTextAlignment(.center)
            .font(.system(size: 28, weight: .semibold, design: .monospaced))
            .frame(height: 56)
            .background(AppColors.surface)
            .overlay(
                RoundedRectangle(cornerRadius: AppRadius.medium)
                    .stroke(AppColors.border.opacity(0.4), lineWidth: 1)
            )
            .clipShape(RoundedRectangle(cornerRadius: AppRadius.medium))
    }
}
