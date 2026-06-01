import SwiftUI

struct AppShadow {
    let color: Color
    let radius: CGFloat
    let x: CGFloat
    let y: CGFloat

    static let card = AppShadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 4)
}
