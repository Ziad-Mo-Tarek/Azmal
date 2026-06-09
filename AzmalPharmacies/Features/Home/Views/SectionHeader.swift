import SwiftUI

struct SectionHeader: View {
    let title: String
    var actionTitle: String?
    var action: (() -> Void)?

    var body: some View {
        HStack {
            Text(title)
                .font(AppTypography.bodySemiboldSmall)
            Spacer()
            if let actionTitle, let action {
                Button(actionTitle, action: action)
                    .font(AppTypography.body)
                    .foregroundStyle(AppColors.primary)
            }
        }
    }
}
