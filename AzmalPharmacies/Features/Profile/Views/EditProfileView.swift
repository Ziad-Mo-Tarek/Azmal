import SwiftUI

struct EditProfileView: View {
    @State private var name = ""
    @State private var email = ""

    var body: some View {
        VStack(spacing: AppSpacing.large) {
            AppTextField(title: "Name", text: $name)
            AppTextField(title: "Email", text: $email, keyboardType: .emailAddress)
            PrimaryButton(title: "Save", systemImage: "checkmark") {}
        }
        .appScreenPadding()
        .navigationTitle("Edit Profile")
    }
}
