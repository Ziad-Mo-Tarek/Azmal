import SwiftUI

struct LoginView: View {
    @State private var phone = ""
    @State private var password = ""

    var body: some View {
        VStack(spacing: AppSpacing.large) {
            AppTextField(title: "Phone", text: $phone, keyboardType: .phonePad)
            AppTextField(title: "Password", text: $password, isSecure: true)
            PrimaryButton(title: "Login", systemImage: "arrow.right") {}
        }
        .appScreenPadding()
        .navigationTitle("Login")
    }
}
