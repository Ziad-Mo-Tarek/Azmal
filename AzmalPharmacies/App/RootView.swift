import SwiftUI

struct RootView: View {
    @State private var appState = AppState()
    @State private var dependencies = DependencyContainer.live

    var body: some View {
        Group {
            switch appState.phase {
            case .splash:
                SplashView()

            case .onboarding:
                OnboardingView {
                    // Mark onboarding as seen then advance to main
                    UserDefaults.standard.set(true, forKey: AppStorageKeys.hasSeenOnboarding)
                    withAnimation {
                        appState.phase = .main
                    }
                }

            case .main:
                MainTabView()
                    .fullScreenCover(isPresented: Binding(
                        get: { appState.showAuthSheet },
                        set: { appState.showAuthSheet = $0 }
                    )) {
                        AuthView()
                    }
            }
        }
        .environment(appState)
        .environment(dependencies)
    }
}

#Preview {
    RootView()
}
