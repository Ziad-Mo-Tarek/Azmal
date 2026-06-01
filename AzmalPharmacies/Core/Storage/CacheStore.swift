import Foundation

final class CacheStore<Key: Hashable, Value> {
    private var storage: [Key: Value] = [:]

    subscript(key: Key) -> Value? {
        get { storage[key] }
        set { storage[key] = newValue }
    }

    func removeAll() {
        storage.removeAll()
    }
}
