import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView()
            .tint(AppColors.primary)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
