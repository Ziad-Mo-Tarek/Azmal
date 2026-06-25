import Foundation
import Observation

@Observable
final class SplashViewModel {

    /// Runs the app initialisation sequence:
    /// 1. Waits for the splash animation to finish.
    /// 2. Restores any persisted auth session (stub for now).
    /// 3. Returns the correct `AppPhase` the app should transition to.
    func initializeApp(
        authSession: AuthSession,
        tokenProvider: TokenProvider
    ) async -> AppPhase {
        // Show splash for at least 2 seconds
        try? await Task.sleep(for: .seconds(2))

        // ── Stub auth restore ────────────────────────────────────────────
        // When real auth lands, replace the UserDefaults check with a
        // Keychain token validation + profile fetch.
        let isLoggedIn = UserDefaults.standard.bool(forKey: AppStorageKeys.isLoggedIn)
        if isLoggedIn {
            // Restore a lightweight stub user so the rest of the app
            // can read `authSession.currentUser` without an API call.
            let stubUser = User(id: 0, name: "User", phone: "", email: nil)
            authSession.update(user: stubUser)
        }

        // ── Decide next phase ────────────────────────────────────────────
        let hasSeenOnboarding = UserDefaults.standard.bool(forKey: AppStorageKeys.hasSeenOnboarding)
        return hasSeenOnboarding ? .main : .onboarding
    }
}
