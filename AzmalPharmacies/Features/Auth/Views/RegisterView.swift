import SwiftUI

struct RegisterView: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var password = ""
    @State private var confirmPassword = ""

    @Environment(DependencyContainer.self) private var dependencies
    @Environment(AppState.self) private var appState
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: AppSpacing.large) {
                AppTextField(
                    title: "First Name",
                    text: $firstName,
                    leadingIcon: .system("person")
                )

                AppTextField(
                    title: "Last Name",
                    text: $lastName,
                    leadingIcon: .system("person")
                )
            }

            AppTextField(
                title: "Enter Your Email",
                text: $email,
                leadingIcon: .system("envelope")
            )

            AppTextField(
                title: "Enter Your Password",
                text: $password,
                leadingIcon: .system("lock"),
                isSecure: true
            )

            AppTextField(
                title: "Confirm Your Password",
                text: $confirmPassword,
                leadingIcon: .system("lock"),
                isSecure: true
            )

            AppTextField(
                title: "Enter Your Phone Number",
                text: $phone,
                leadingIcon: .system("phone"),
                keyboardType: .phonePad
            )

            PrimaryButton(title: "Sign Up") {
                stubRegister()
            }
            .padding(.top, AppSpacing.large)
        }
    }

    // MARK: – Stub register
    /// Creates a placeholder user from the form fields and opens a session.
    /// Replace with the real registration API call when the endpoint is ready.
    private func stubRegister() {
        let fullName = [firstName, lastName]
            .filter { !$0.isEmpty }
            .joined(separator: " ")

        let stubUser = User(
            id: 1,
            name: fullName.isEmpty ? "New User" : fullName,
            phone: phone,
            email: email.isEmpty ? nil : email
        )
        dependencies.authSession.update(user: stubUser)
        UserDefaults.standard.set(true, forKey: AppStorageKeys.isLoggedIn)
        appState.showAuthSheet = false
    }
}

#Preview {
    RegisterView()
        .environment(DependencyContainer())
        .environment(AppState())
}
