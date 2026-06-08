import SwiftUI

// MARK: - Typography Reference
// Top → Bottom by size:
//
// Heading            → Bold      → 28pt
// Heading-medium     → Medium    → 24pt
// Button label       → Semibold  → 22pt
// Heading-small      → Semibold  → 20pt
// Body-large         → Regular   → 16pt
// Body-medium        → Medium    → 16pt
// Body-semibol-small → Semibold  → 13pt
// Body-medium-small  → Medium    → 13pt
// Body-small         → Regular   → 13pt
// Body-sembold-Tiny  → Semibold  → 11pt
// Body-Tiny          → Regular   → 11pt
// Caption-medium     → Medium    → 10pt
// Caption-small      → Regular   → 7pt
//
// When design specs are unclear, use this list to quickly match the
// typography token by visual size and weight instead of inspecting the enum.

enum AppTypography {
    enum Style {
        case heading
        case headingMedium
        case buttonLabel
        case headingSmall
        case bodyLarge
        case bodyMedium
        case bodySemiboldSmall
        case bodyMediumSmall
        case bodySmall
        case bodySemiboldTiny
        case bodyTiny
        case captionMedium
        case captionSmall

        var size: CGFloat {
            switch self {
            case .heading:
                return 28
            case .headingMedium:
                return 24
            case .buttonLabel:
                return 22
            case .headingSmall:
                return 20
            case .bodyLarge, .bodyMedium:
                return 16
            case .bodySemiboldSmall, .bodyMediumSmall, .bodySmall:
                return 13
            case .bodySemiboldTiny, .bodyTiny:
                return 11
            case .captionMedium:
                return 10
            case .captionSmall:
                return 7
            }
        }

//        var lineHeight: CGFloat {
//            size * 1.6
//        }
//
//        var lineSpacing: CGFloat {
//            max(lineHeight - size, 0)
//        }

        var designName: String {
            switch self {
            case .heading:
                return "Heading"
            case .headingMedium:
                return "Heading-medium"
            case .buttonLabel:
                return "Button label"
            case .headingSmall:
                return "Heading-small"
            case .bodyLarge:
                return "Body-large"
            case .bodyMedium:
                return "Body-medium"
            case .bodySemiboldSmall:
                return "Body-semibol-small"
            case .bodyMediumSmall:
                return "Body-medium-small"
            case .bodySmall:
                return "Body-small"
            case .bodySemiboldTiny:
                return "Body-sembold-Tiny"
            case .bodyTiny:
                return "Body-Tiny"
            case .captionMedium:
                return "Caption-medium"
            case .captionSmall:
                return "Caption-small"
            }
        }

        var weight: Font.Weight {
            switch self {
            case .heading:
                return .bold
            case .buttonLabel, .headingSmall, .bodySemiboldSmall, .bodySemiboldTiny:
                return .semibold
            case .headingMedium, .bodyMedium, .bodyMediumSmall, .captionMedium:
                return .medium
            case .bodyLarge, .bodySmall, .bodyTiny, .captionSmall:
                return .regular
            }
        }

        var fontName: String {
            switch weight {
            case .bold:
                return "Poppins-Bold"
            case .semibold:
                return "Poppins-SemiBold"
            case .medium:
                return "Poppins-Medium"
            case .light:
                return "Poppins-Light"
            default:
                return "Poppins-Regular"
            }
        }

        var relativeTextStyle: Font.TextStyle {
            switch self {
            case .heading:
                return .largeTitle
            case .headingMedium:
                return .title
            case .buttonLabel:
                return .title2
            case .headingSmall:
                return .title3
            case .bodyLarge, .bodyMedium:
                return .body
            case .bodySemiboldSmall, .bodyMediumSmall, .bodySmall:
                return .subheadline
            case .bodySemiboldTiny, .bodyTiny:
                return .footnote
            case .captionMedium:
                return .headline
            case .captionSmall:
                return .caption
            }
        }

        var font: Font {
            .custom(fontName, size: size, relativeTo: relativeTextStyle)
        }
    }

    static let heading = Style.heading.font
    static let headingMedium = Style.headingMedium.font
    static let buttonLabel = Style.buttonLabel.font
    static let headingSmall = Style.headingSmall.font
    static let bodyLarge = Style.bodyLarge.font
    static let bodyMedium = Style.bodyMedium.font
    static let bodySemiboldSmall = Style.bodySemiboldSmall.font
    static let bodyMediumSmall = Style.bodyMediumSmall.font
    static let bodySmall = Style.bodySmall.font
    static let bodySemiboldTiny = Style.bodySemiboldTiny.font
    static let bodyTiny = Style.bodyTiny.font
    static let captionMedium = Style.captionMedium.font
    static let captionSmall = Style.captionSmall.font

    static let largeTitle = Style.heading.font
    static let title = Style.buttonLabel.font
    static let headline = Style.headingSmall.font
    static let body = Style.bodyMedium.font
    static let caption = Style.bodySmall.font
}

struct AppTextModifier: ViewModifier {
    let style: AppTypography.Style
    let color: Color
    let weight: Font.Weight?

    func body(content: Content) -> some View {
        content
            .font(style.font)
            .fontWeight(weight ?? style.weight)
//            .lineSpacing(style.lineSpacing)
            .foregroundStyle(color)
    }
}

extension View {
    func appTextStyle(
        _ style: AppTypography.Style,
        color: Color = AppColors.textPrimary,
        weight: Font.Weight? = nil
    ) -> some View {
        modifier(AppTextModifier(style: style, color: color, weight: weight))
    }
}
