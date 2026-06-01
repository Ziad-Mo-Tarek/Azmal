import Foundation

protocol PreferencesStoring {
    func bool(for key: String) -> Bool
    func set(_ value: Bool, for key: String)
}

struct UserDefaultsStore: PreferencesStoring {
    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    func bool(for key: String) -> Bool {
        defaults.bool(forKey: key)
    }

    func set(_ value: Bool, for key: String) {
        defaults.set(value, forKey: key)
    }
}
