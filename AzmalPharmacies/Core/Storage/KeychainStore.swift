import Foundation

protocol SecureStoring {
    func string(for key: String) -> String?
    func set(_ value: String?, for key: String)
}

final class KeychainStore: SecureStoring {
    private var memoryStore: [String: String] = [:]

    func string(for key: String) -> String? {
        memoryStore[key]
    }

    func set(_ value: String?, for key: String) {
        memoryStore[key] = value
    }
}
