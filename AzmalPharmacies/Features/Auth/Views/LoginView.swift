import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""

    @Environment(DependencyContainer.self) private var dependencies
    @Environment(AppState.self) private var appState
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 0) {
            AppTextField(
                title: "Enter Your Email",
                text: $email,
                leadingIcon: .system("envelope")
            )
            .padding(.bottom, 20)

            AppTextField(
                title: "Enter Your Password",
                text: $password,
                leadingIcon: .system("lock"),
                isSecure: true
            )
            .padding(.bottom, 8)

            Text(LocalizedStringKey("Forgot password?"))
                .appTextStyle(.bodySmall, color: .primaryApp)
                .frame(maxWidth: .infinity, alignment: .trailing)

            PrimaryButton(title: "Log In") {
                stubLogin()
            }
            .padding(.top, 28)
        }
    }

    // MARK: – Stub login
    /// Persists a lightweight session flag and populates `AuthSession` with a
    /// placeholder user. Replace the body of this function with the real API
    /// call once the auth endpoint is ready.
    private func stubLogin() {
        let stubUser = User(
            id: 1,
            name: email.isEmpty ? "User" : email.components(separatedBy: "@").first ?? "User",
            phone: "",
            email: email.isEmpty ? nil : email
        )
        dependencies.authSession.update(user: stubUser)
        UserDefaults.standard.set(true, forKey: AppStorageKeys.isLoggedIn)
        appState.showAuthSheet = false
    }
}

#Preview {
    LoginView()
        .environment(DependencyContainer())
        .environment(AppState())
}
