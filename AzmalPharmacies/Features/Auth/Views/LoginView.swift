import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""

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
            
            PrimaryButton(
                title: "Log In"
            ) {
            }
            .padding(.top, 28)
        }
    }
}


#Preview {
    LoginView()
}
