import SwiftUI

struct RootView: View {
    @State private var appState = AppState()
    @State private var dependencies = DependencyContainer.live

    var body: some View {
        MainTabView()
            .environment(appState)
            .environment(dependencies)
    }
}

#Preview {
    RootView()
}
