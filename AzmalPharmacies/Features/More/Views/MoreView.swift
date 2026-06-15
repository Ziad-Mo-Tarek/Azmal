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
                        MoreRowCell(icon: "person.fill",          title: "more.profile", isDestructive: false)      { router.push(.editProfile) }
                        MoreRowCell(icon: "heart.fill",           title: "more.favorites", isDestructive: false)    { router.push(.favorites) }
                        MoreRowCell(iconImage: .myOrdersProfileIcon,              title: "more.myOrders")     { router.push(.orderDetails(id: 0)) }
                        MoreRowCell(iconImage: .notificationProfileIcon,            title: "more.notification") { }
                    }
                    
                    // App Settings Section
                    sectionBlock(header: "more.appSettings") {
                        MoreRowCell(iconImage: .languageIcon,    title: "more.language")           { router.push(.settings) }
                        MoreRowCell(iconImage: .helpProfileIcon, title: "more.helpSupport")        { router.push(.help) }
                        MoreRowCell(iconImage: .termsAndconditionsProfileIcon,            title: "more.termsConditions")    { }
                        MoreRowCell(iconImage: .privacyProfileIcon,              title: "more.privacyPolicy")      { }
                        MoreRowCell(iconImage: .aboutUsProfileIcon,         title: "more.aboutUs")            { }
                        MoreRowCell(iconImage: .logoutProfileIcon,
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
                    .frame(width: 57, height: 57)
                
                ImageLoader(urlString: AppConstants.randomeImage)
                    .frame(width: 56, height: 56, alignment: .center)
                    .clipShape(Circle())
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(dependencies.authSession.currentUser?.name ?? String("Ziad Tarek"))
                    .appTextStyle(.bodyLarge, color: .appDark, weight: .semibold)

                Text(dependencies.authSession.currentUser?.email ?? "ZZZ123@gmail.com")
                    .appTextStyle(.bodySmall, color: .gray.opacity(0.7))
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
