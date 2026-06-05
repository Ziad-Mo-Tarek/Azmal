import SwiftUI

struct ForgotPasswordView: View {
    @State private var phone = ""

    var body: some View {
        VStack(spacing: AppSpacing.large) {
            AppTextField(title: "Phone", text: $phone, leadingIcon: .system("phone"), keyboardType: .phonePad)
            PrimaryButton(title: "Send Code", systemImage: "paperplane") {}
        }
        .appScreenPadding()
        .navigationTitle("Forgot Password")
    }
}
