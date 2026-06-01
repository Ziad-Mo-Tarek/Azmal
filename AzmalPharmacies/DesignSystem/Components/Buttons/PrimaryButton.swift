import SwiftUI

struct PrimaryButton: View {
    let title: String
    var systemImage: String?
    var isLoading = false
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(/*spacing: AppSpacing.small*/) {
                if isLoading {
                    ProgressView()
                        .tint(.white)
                } else if let systemImage {
                    Image(systemName: systemImage)
                }
                Text(title)
//                    .font(AppTypography.headline)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
        }
        .buttonStyle(.plain)
        .foregroundStyle(.white)
//        .background(AppColors.primary)
//        .clipShape(RoundedRectangle(cornerRadius: AppRadius.medium))
        .disabled(isLoading)
    }
}
