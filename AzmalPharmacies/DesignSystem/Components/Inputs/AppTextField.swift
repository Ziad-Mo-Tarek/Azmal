import SwiftUI

// MARK: - AppIcon

/// Abstraction over icon sources so call sites don't care whether
/// an icon comes from SF Symbols or a custom image asset.
enum AppIcon {
    case system(String)   // SF Symbol  e.g.  .system("phone")
    case asset(String)    // Image asset e.g.  .asset("ic_email")
}

// MARK: - Icon View Helper

private extension AppIcon {
    @ViewBuilder
    var view: some View {
        switch self {
        case .system(let name):
            Image(systemName: name)
                .resizable()
                .scaledToFit()
        case .asset(let name):
            Image(name)
                .resizable()
                .scaledToFit()
        }
    }
}

// MARK: - AppTextField

struct AppTextField: View {
    let title: LocalizedStringKey
    @Binding var text: String
    var leadingIcon: AppIcon? = nil
    var leadingIconColor: Color = .gray
    var isSecure = false
    var keyboardType: UIKeyboardType = .default
    
    @State private var isPasswordVisible = false

    var body: some View {
        HStack(spacing: AppSpacing.medium) {
            // Leading icon — works for both SF Symbols and image assets
            if let leadingIcon {
                leadingIcon.view
                    .frame(width: 20, height: 20)
                    .foregroundColor(leadingIconColor)
            }

            // Input field with custom placeholder overlay
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(title)
                        .appTextStyle(.bodyMediumSmall, color: .gray)
                }

                if isSecure && !isPasswordVisible {
                    SecureField("", text: $text)
                        .keyboardType(keyboardType)
                        .appTextStyle(.bodyMediumSmall, color: .appDark)
                } else {
                    TextField("", text: $text)
                        .keyboardType(keyboardType)
                        .appTextStyle(.bodyMediumSmall, color: .appDark)
                }
            }
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()

            // Trailing eye toggle — only appears on secure fields
            if isSecure {
                Button(action: { isPasswordVisible.toggle() }) {
                    Image(isPasswordVisible ? .eyeOpenedIcon : .eyeClosedIcon)
                        .foregroundColor(leadingIconColor)
                }
            }
        }
        .padding(.horizontal, AppSpacing.large)
        .frame(height: 56)
        .background(AppColors.surface)
        .clipShape(RoundedRectangle(cornerRadius: AppRadius.large))
        .overlay(
            RoundedRectangle(cornerRadius: AppRadius.large)
                .stroke(AppColors.primary, lineWidth: 0.3)
        )
    }
}

// MARK: - Preview

#Preview("All Variants") {
    @Previewable @State var name     = ""
    @Previewable @State var email    = ""
    @Previewable @State var phone    = ""
    @Previewable @State var password = ""
    @Previewable @State var filled   = "John Appleseed"

    VStack(spacing: 16) {

        // No icon
        AppTextField(title: "No Icon", text: $name)

        // SF Symbol leading icon
        AppTextField(title: "Enter Your Email", text: $email, leadingIcon: .system("envelope"))

        // SF Symbol leading icon + phone keyboard
        AppTextField(title: "Enter Your Phone Number", text: $phone, leadingIcon: .system("phone"), keyboardType: .phonePad)

        // Image asset leading icon (swap "ic_email" for a real asset name in your project)
        AppTextField(title: "Asset Icon Example", text: $email, leadingIcon: .asset("eyeClosedIcon"))

        // Secure field — trailing eye toggle included automatically
        AppTextField(title: "Enter Your Password", text: $password, leadingIcon: .system("lock"), isSecure: true)

        // Pre-filled state
        AppTextField(title: "Name", text: $filled, leadingIcon: .system("person"))
    }
    .padding()
}
