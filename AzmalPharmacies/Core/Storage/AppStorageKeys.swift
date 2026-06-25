import Foundation

/// Centralised namespace for all UserDefaults keys used in the app.
/// Always use these constants instead of raw strings.
enum AppStorageKeys {

    // MARK: – Onboarding
    /// `true` once the user has completed the onboarding flow at least once.
    static let hasSeenOnboarding = "hasSeenOnboarding"

    // MARK: – Auth (stub – replace with Keychain token check when real auth lands)
    /// `true` when a user has logged in. Persisted across launches as a lightweight
    /// session indicator; the real source-of-truth will be a Keychain token.
    static let isLoggedIn = "isLoggedIn"
}
