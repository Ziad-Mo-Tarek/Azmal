import SwiftUI

extension View {
    func appScreenPadding() -> some View {
        padding(.horizontal, AppSpacing.large)
    }
    
    func customCornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(CustomCorner(radius: radius, corners: corners))
    }
    
}
