import SwiftUI

struct RegisterView: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var password = ""
    @State private var confirmPassword = ""

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

            PrimaryButton(
                title: "Sign Up"
            ) {
            }
            .padding(.top, AppSpacing.large)
        }
    }
}


#Preview {
    RegisterView()
}
