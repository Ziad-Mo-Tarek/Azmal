import Foundation

protocol TokenProvider {
    var accessToken: String? { get }
    func save(accessToken: String?)
    func clear()
}

final class KeychainTokenProvider: TokenProvider {
    private enum Keys {
        static let accessToken = "accessToken"
    }

    private let store: SecureStoring

    init(store: SecureStoring = KeychainStore()) {
        self.store = store
    }

    var accessToken: String? {
        store.string(for: Keys.accessToken)
    }

    func save(accessToken: String?) {
        store.set(accessToken, for: Keys.accessToken)
    }

    func clear() {
        store.set(nil, for: Keys.accessToken)
    }
}
