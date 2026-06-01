import SwiftUI

struct ErrorStateView: View {
    let message: String
    var retry: (() -> Void)?

    var body: some View {
        VStack(spacing: AppSpacing.large) {
            EmptyStateView(title: "Something went wrong", message: message, systemImage: "exclamationmark.triangle")
            if let retry {
                PrimaryButton(title: "Try Again", systemImage: "arrow.clockwise", action: retry)
            }
        }
        .padding(AppSpacing.large)
    }
}
