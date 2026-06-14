import SwiftUI

struct MoreView: View {
    @Environment(DependencyContainer.self) private var dependencies
    @Environment(AppRouter.self) private var router

    var body: some View {
        VStack(spacing: 0) {
            // ── Navigation Bar ──────────────────────────────────
            AppNavigationBar(
                title: String(localized: "More"),
                showBackButton: false
            )
//            .ignoresSafeArea(edges: .top)
            .background(.primaryApp)

            // ── Content ─────────────────────────────────────────
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: AppSpacing.xLarge) {

                    // User Header
                    userHeader

                    // Account Section
                    sectionBlock(header: "more.account") {
                        MoreRowCell(icon: "person",          title: "more.profile")      { router.push(.editProfile) }
                        MoreRowCell(icon: "heart",           title: "more.favorites")    { router.push(.addresses) }
                        MoreRowCell(icon: "bag",             title: "more.myOrders")     { router.push(.orderDetails(id: 0)) }
                        MoreRowCell(icon: "bell",            title: "more.notification") { }
                    }

                    // App Settings Section
                    sectionBlock(header: "more.appSettings") {
                        MoreRowCell(icon: "character.bubble",    title: "more.language")           { router.push(.settings) }
                        MoreRowCell(icon: "questionmark.circle", title: "more.helpSupport")        { router.push(.help) }
                        MoreRowCell(icon: "doc.text",            title: "more.termsConditions")    { }
                        MoreRowCell(icon: "shield",              title: "more.privacyPolicy")      { }
                        MoreRowCell(icon: "info.circle",         title: "more.aboutUs")            { }
                        MoreRowCell(icon: "rectangle.portrait.and.arrow.right",
                                                                 title: "more.logout",
                                                                 isDestructive: true)              { }
                    }
                }
                .padding(.horizontal, AppSpacing.large)
                .padding(.top, AppSpacing.xLarge)
                .padding(.bottom, AppSpacing.xLarge)
            }
        }
        .background(AppColors.background.ignoresSafeArea())
        .toolbar(.hidden, for: .navigationBar)
    }

    // MARK: - Sub-views

    private var userHeader: some View {
        HStack(spacing: AppSpacing.medium) {
            // Avatar
            ZStack {
                Circle()
                    .fill(AppColors.primary.opacity(0.15))
                    .frame(width: 60, height: 60)
                Image(systemName: "person.fill")
                    .font(.system(size: 30))
                    .foregroundColor(AppColors.primary)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(dependencies.authSession.currentUser?.name ?? String(localized: "more.guest"))
                    .appTextStyle(.bodyLarge, color: .appDark, weight: .semibold)

                Text(dependencies.authSession.currentUser?.email ?? "")
                    .appTextStyle(.bodySmall, color: .appSecondary)
            }

            Spacer()
        }
    }

    @ViewBuilder
    private func sectionBlock<Content: View>(
        header: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: AppSpacing.medium) {
            Text(LocalizedStringKey(header))
                .appTextStyle(.headingSmall, color: .appDark, weight: .semibold)

            VStack(spacing: AppSpacing.small) {
                content()
            }
        }
    }
}

#Preview {
    MoreView()
        .environment(DependencyContainer())
        .environment(AppRouter())
}
