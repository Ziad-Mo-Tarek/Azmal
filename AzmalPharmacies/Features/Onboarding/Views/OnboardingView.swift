import SwiftUI

private struct OnboardingPage: Identifiable {
    let id: Int
    let titleKey: String
    let subtitleKey: String
    let imageName: String
    let buttonTitleKey: String
}

struct OnboardingView: View {
    @State private var selectedPage = 0

    var onFinish: () -> Void = {}

    private let pages = [
        OnboardingPage(
            id: 0,
            titleKey: "Smart Pharmacy at Your \nFingertips",
            subtitleKey: "onboarding.first.subtitle",
            imageName: "OnBoardingImage_first",
            buttonTitleKey: "onboarding.next"
        ),
        OnboardingPage(
            id: 1,
            titleKey: "onboarding.second.title",
            subtitleKey: "onboarding.second.subtitle",
            imageName: "OnBoardingImage_second",
            buttonTitleKey: "onboarding.getStarted"
        )
    ]

    var body: some View {
        VStack(spacing: AppSpacing.large) {
            TabView(selection: $selectedPage) {
                ForEach(pages) { page in
                    OnboardingPageView(page: page)
                        .tag(page.id)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))

            pageIndicator

            AppButton(title: localized(pages[selectedPage].buttonTitleKey)) {
                if selectedPage < pages.count - 1 {
                    withAnimation {
                        selectedPage += 1
                    }
                } else {
                    onFinish()
                }
            }
            .padding(.horizontal, AppSpacing.xLarge)
        }
        .padding(.vertical, AppSpacing.xLarge)
        .background(AppColors.white.ignoresSafeArea())
    }

    private var pageIndicator: some View {
        HStack(spacing: AppSpacing.xSmall) {
            ForEach(pages) { page in
                Circle()
                    .fill(page.id == selectedPage ? AppColors.primary : AppColors.disabledButton)
                    .frame(width: 12, height: 12)
            }
        }
    }

    private func localized(_ key: String) -> String {
        String(localized: String.LocalizationValue(key))
    }
}

private struct OnboardingPageView: View {
    let page: OnboardingPage

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xLarge) {
            Spacer(minLength: 0)

            Image(page.imageName)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .frame(height: 245)

            VStack(alignment: .leading, spacing: AppSpacing.medium) {
                Text(LocalizedStringKey(page.titleKey))
                    .appTextStyle(.headingSmall, color: .appDark)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: true, vertical: false)

                Text(LocalizedStringKey(page.subtitleKey))
                    .appTextStyle(.bodySemiboldTiny, color: .appDark)
                    .multilineTextAlignment(.leading)
            }
            .padding(.horizontal, AppSpacing.xLarge)
            
            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    OnboardingView()
}
