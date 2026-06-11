import Foundation
import Observation

@Observable
final class SplashViewModel {
    
    // Simulate an initialization process like fetching tokens or configuration
    func initializeApp(completion: @escaping () -> Void) {
        Task {
            // Wait for 2 seconds to show the splash screen
            try? await Task.sleep(for: .seconds(2))
            
            await MainActor.run {
                completion()
            }
        }
    }
}
