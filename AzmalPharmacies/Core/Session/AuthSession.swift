import Foundation
import Observation

@Observable
final class AuthSession {
    private(set) var currentUser: User?

    var isAuthenticated: Bool {
        currentUser != nil
    }

    func update(user: User?) {
        currentUser = user
    }
}
