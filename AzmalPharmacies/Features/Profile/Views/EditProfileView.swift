import SwiftUI

// MARK: - EditProfileView

struct EditProfileView: View {
    @Environment(AppRouter.self) private var router
    @Environment(DependencyContainer.self) private var dependencies

    // MARK: - Form State

    @State private var firstName = ""
    @State private var lastName = ""
    @State private var phoneNumber = ""
    @State private var email = ""

    // MARK: - Account Type

    /// `true`  → Google-linked variant: email field is locked, no Change Password row.
    /// `false` → Password variant: email has a chevron action, Change Password row is shown.
    ///
    /// Replace with a real `authProvider` flag on `User` once the backend supplies it.
    private var isGoogleLinked: Bool {
        dependencies.authSession.currentUser?.email?.lowercased().hasSuffix("gmail.com") == true
    }

    // MARK: - Body

    var body: some View {
        VStack(spacing: 0) {

            // ── Navigation Bar ────────────────────────────────────────────────
            AppNavigationBar(
                title: String(localized: "Edit Profile"),
                showBackButton: true,
                backAction: { router.pop() }
            )
            .background(AppColors.primary)

            // ── Scrollable Content ────────────────────────────────────────────
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: AppSpacing.xLarge) {
                    formSection
                    actionSection
                }
                .appScreenPadding()
                .padding(.vertical, AppSpacing.xLarge)
            }

            // ── Pinned Save Button ────────────────────────────────────────────
            VStack(spacing: 0) {
                PrimaryButton(title: String(localized: "edit_profile.save_changes")) {
                    // TODO: dispatch save via ViewModel
                }
                .padding(AppSpacing.large)
                .background(AppColors.surface)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .ignoresSafeArea(.keyboard)
        .onAppear(perform: prefillFromSession)
    }

    // MARK: - Form Section

    private var formSection: some View {
        VStack(spacing: AppSpacing.large) {

            // First Name
            fieldRow(label: "First Name") {
                AppTextField(title: "First Name", text: $firstName)
            }

            // Last Name
            fieldRow(label: "Last Name") {
                AppTextField(title: "Last Name", text: $lastName)
            }

            // Phone Number ── leading country-code chip variant
            fieldRow(label: "Phone Number") {
                AppTextField(
                    title: "Enter Your Phone Number",
                    text: $phoneNumber,
                    leadingText: "+20",
                    keyboardType: .phonePad,
                    trailingAction: {
                        // TODO: navigate to phone-change flow
                    }
                )
            }

            // Email ── two variants depending on auth provider
            fieldRow(label: "Email") {
                if isGoogleLinked {
                    AppTextField(
                        title: "Email",
                        text: $email,
                        isDisabled: true,
                        footerText: String(localized: "edit_profile.email_locked_notice")
                    )
                } else {
                    AppTextField(
                        title: "Email",
                        text: $email,
                        trailingAction: {
                            // TODO: navigate to email-change flow
                        }
                    )
                }
            }
        }
    }

    // MARK: - Action Section

    private var actionSection: some View {
        VStack(spacing: AppSpacing.large) {

            // Change Password — password-account variant only
            if !isGoogleLinked {
                Button {
                    // TODO: router.push(.changePassword)
                } label: {
                    HStack(spacing: AppSpacing.small) {
                        Image(systemName: "lock")
                            .font(.system(size: 18))
                            .foregroundColor(.appDark)
                        Text(String(localized: "edit_profile.change_password"))
                            .appTextStyle(.bodyMedium, color: .appDark)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.appDark)
                    }
                }
            }

            // Delete Account — always present, destructive
            Button {
                // TODO: show confirmation alert
            } label: {
                HStack(spacing: AppSpacing.small) {
                    Image(systemName: "trash")
                        .font(.system(size: 18))
                        .foregroundColor(AppColors.primary)
                    Text(String(localized: "edit_profile.delete_account"))
                        .appTextStyle(.bodyMedium, color: AppColors.primary)
                    Spacer()
                }
            }
        }
        .padding(.top, AppSpacing.small)
    }

    // MARK: - Helpers

    /// Stacks a small label above any field content, matching the Figma label style.
    @ViewBuilder
    private func fieldRow<Content: View>(
        label: LocalizedStringKey,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            Text(label)
                .appTextStyle(.bodySmall, color: .gray )
            content()
        }
    }

    /// Seeds the form from the auth session on appear.
    private func prefillFromSession() {
        guard let user = dependencies.authSession.currentUser else { return }
        let parts = user.name.split(separator: " ", maxSplits: 1)
        firstName   = parts.first.map(String.init) ?? user.name
        lastName    = parts.dropFirst().first.map(String.init) ?? ""
        phoneNumber = user.phone
        email       = user.email ?? ""
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        EditProfileView()
            .environment(AppRouter())
            .environment(DependencyContainer())
    }
}
