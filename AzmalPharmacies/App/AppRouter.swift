import SwiftUI

@Observable
final class AppRouter {
    var path = NavigationPath()

    func push(_ route: AppRoute) {
        path.append(route)
    }

    func popToRoot() {
        path = NavigationPath()
    }
    
    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }
}
