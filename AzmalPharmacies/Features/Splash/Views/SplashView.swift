import SwiftUI

struct SplashView: View {
    @State private var viewModel = SplashViewModel()
    @Environment(AppState.self) private var appState
    @Environment(DependencyContainer.self) private var dependencies

    @State private var size: CGFloat = 0.8
    @State private var opacity: Double = 0.0

    var body: some View {
        ZStack {
            AppColors.primary
                .ignoresSafeArea()

            VStack {
                Image(.logoCircle)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 180, height: 180)
                    .scaleEffect(size)
                    .opacity(opacity)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .onAppear {
            withAnimation(.easeIn(duration: 1.0)) {
                size = 1.0
                opacity = 1.0
            }

            Task {
                let nextPhase = await viewModel.initializeApp(
                    authSession: dependencies.authSession,
                    tokenProvider: dependencies.tokenProvider
                )
                withAnimation {
                    appState.phase = nextPhase
                }
            }
        }
    }
}

#Preview {
    SplashView()
        .environment(AppState())
        .environment(DependencyContainer())
}
