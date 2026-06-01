import SwiftUI

struct PromotionalBannerView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: AppSpacing.small) {
                Text("Upload your prescription")
                    .font(AppTypography.title)
                Text("We will prepare your order from the nearest pharmacy.")
                    .font(AppTypography.body)
                    .foregroundStyle(.white.opacity(0.85))
            }
            Spacer()
            Image(systemName: "doc.text.image")
                .font(.system(size: 36))
        }
        .foregroundStyle(.white)
        .padding(AppSpacing.large)
        .background(AppColors.primary)
        .clipShape(RoundedRectangle(cornerRadius: AppRadius.large))
    }
}
