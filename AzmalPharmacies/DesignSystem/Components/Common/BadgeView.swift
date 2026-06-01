import SwiftUI

struct BadgeView: View {
    let text: String
    var tint: Color = .primary

    var body: some View {
        Text(text)
//            .font(AppTypography.caption)
//            .padding(.horizontal, AppSpacing.small)
//            .padding(.vertical, AppSpacing.xSmall)
            .foregroundStyle(tint)
            .background(tint.opacity(0.1))
            .clipShape(Capsule())
    }
}
