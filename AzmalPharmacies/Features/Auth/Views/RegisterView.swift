import SwiftUI

struct RegisterView: View {
    @State private var name = ""
    @State private var phone = ""
    @State private var password = ""

    var body: some View {
        VStack(spacing: AppSpacing.large) {
            AppTextField(title: "Name", text: $name)
            AppTextField(title: "Phone", text: $phone, keyboardType: .phonePad)
            AppTextField(title: "Password", text: $password, isSecure: true)
            PrimaryButton(title: "Create Account", systemImage: "person.badge.plus") {}
        }
        .appScreenPadding()
        .navigationTitle("Register")
    }
}
