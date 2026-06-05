import SwiftUI

struct EditProfileView: View {
    @State private var name = ""
    @State private var email = ""

    var body: some View {
        VStack(spacing: AppSpacing.large) {
            AppTextField(title: "Name", text: $name, leadingIcon: .system("person"))
            AppTextField(title: "Email", text: $email, leadingIcon: .system("envelope"), keyboardType: .emailAddress)
            PrimaryButton(title: "Save", systemImage: "checkmark") {}
        }
        .appScreenPadding()
        .navigationTitle("Edit Profile")
    }
}
