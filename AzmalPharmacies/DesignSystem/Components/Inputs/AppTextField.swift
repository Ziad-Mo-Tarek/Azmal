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
    /// A short text chip shown before a divider, e.g. "+20" for phone fields.
    var leadingText: String? = nil
    var isSecure = false
    var keyboardType: UIKeyboardType = .default
    /// When `true` the field is read-only and rendered in a muted style.
    var isDisabled = false
    /// Optional caption displayed below the field (e.g. a linked-account notice).
    var footerText: String? = nil
    /// When provided a chevron button is shown on the trailing edge and tapping calls this closure.
    var trailingAction: (() -> Void)? = nil

    @State private var isPasswordVisible = false

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
            fieldContainer
            if let footerText {
                Text(footerText)
                    .appTextStyle(.bodyTiny, color: .appSecondary)
                    .padding(.horizontal, AppSpacing.xSmall)
            }
        }
    }

    // MARK: - Field Container

    private var fieldContainer: some View {
        HStack(spacing: 0) {
            // ── Leading text chip (e.g. country code "+20") ──────────────────
            if let leadingText {
                Text(leadingText)
                    .appTextStyle(.bodyMediumSmall, color: isDisabled ? .gray : .appDark)
                    .padding(.horizontal, AppSpacing.medium)
                    .frame(height: 56)

                Divider()
                    .frame(height: 28)
                    .overlay(AppColors.primary.opacity(0.4))
            }

            HStack(spacing: AppSpacing.medium) {
                // ── Leading icon ─────────────────────────────────────────────
                if let leadingIcon {
                    leadingIcon.view
                        .frame(width: 20, height: 20)
                        .foregroundColor(isDisabled ? .gray.opacity(0.6) : leadingIconColor)
                }

                // ── Text input / placeholder ─────────────────────────────────
                ZStack(alignment: .leading) {
                    if text.isEmpty {
                        Text(title)
                            .appTextStyle(.bodyMediumSmall, color: .gray)
                    }

                    if isSecure && !isPasswordVisible {
                        SecureField("", text: $text)
                            .keyboardType(keyboardType)
                            .appTextStyle(.bodyMediumSmall, color: isDisabled ? .gray : .appDark)
                            .disabled(isDisabled)
                    } else {
                        TextField("", text: $text)
                            .keyboardType(keyboardType)
                            .appTextStyle(.bodyMediumSmall, color: isDisabled ? .gray : .appDark)
                            .disabled(isDisabled)
                    }
                }
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()

                // ── Trailing: eye toggle or navigation chevron ────────────────
                if isSecure {
                    Button(action: { isPasswordVisible.toggle() }) {
                        Image(isPasswordVisible ? .eyeOpenedIcon : .eyeClosedIcon)
                            .foregroundColor(leadingIconColor)
                    }
                } else if let trailingAction {
                    Button(action: trailingAction) {
                        Image(systemName: "chevron.right")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(AppColors.primary)
                    }
                }
            }
            .padding(.horizontal, AppSpacing.large)
        }
        .frame(height: 56)
        .background(isDisabled ? Color(.systemGray6) : AppColors.surface)
        .clipShape(RoundedRectangle(cornerRadius: AppRadius.large))
        .overlay(
            RoundedRectangle(cornerRadius: AppRadius.large)
                .stroke(isDisabled ? Color.clear : AppColors.primary, lineWidth: 0.3)
        )
    }
}

// MARK: - Preview

#Preview("All Variants") {
    @Previewable @State var name     = ""
    @Previewable @State var email    = "linked@google.com"
    @Previewable @State var phone    = "1234567891"
    @Previewable @State var password = ""
    @Previewable @State var filled   = "John Appleseed"

    VStack(spacing: 16) {

        // No icon
        AppTextField(title: "No Icon", text: $name)

        // SF Symbol leading icon
        AppTextField(title: "Enter Your Email", text: $email, leadingIcon: .system("envelope"))

        // Phone with leading country-code chip
        AppTextField(
            title: "Phone Number",
            text: $phone,
            leadingText: "+20",
            keyboardType: .phonePad,
            trailingAction: {}
        )

        // Secure field — trailing eye toggle included automatically
        AppTextField(title: "Enter Your Password", text: $password, leadingIcon: .system("lock"), isSecure: true)

        // Disabled field with footer caption
        AppTextField(
            title: "Email",
            text: $email,
            isDisabled: true,
            footerText: "This email is linked to your Google account and cannot be changed here"
        )

        // Pre-filled with trailing chevron (navigate-to action)
        AppTextField(title: "Name", text: $filled, leadingIcon: .system("person"), trailingAction: {})
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}
