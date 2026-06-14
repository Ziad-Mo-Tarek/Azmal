import SwiftUI

struct ProductDetailCard<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.medium) {
            content
        }
        .padding(AppSpacing.large)
        .background(AppColors.surface)
        .clipShape(RoundedRectangle(cornerRadius: AppRadius.large))
    }
}
