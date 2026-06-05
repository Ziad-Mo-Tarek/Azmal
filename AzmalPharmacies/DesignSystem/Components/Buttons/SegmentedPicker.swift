import SwiftUI

// MARK: - SegmentedPicker

/// A fully generic pill-shaped segmented picker that works with any Hashable type.
///
/// Usage:
/// ```swift
/// enum AuthMode { case signUp, login }
///
/// SegmentedPicker(
///     options: [.signUp, .login],
///     selected: $mode,
///     label: { $0 == .signUp ? "Sign Up" : "Log In" },
///     onChange: { newMode in print(newMode) }
/// )
/// ```
struct SegmentedPicker<Option: Hashable>: View {
    let options: [Option]
    @Binding var selected: Option
    let label: (Option) -> String
    var onChange: ((Option) -> Void)? = nil

    // Tracks the frame of the selected segment for the sliding capsule
    @Namespace private var animation

    var body: some View {
        HStack(spacing: 0) {
            ForEach(options, id: \.self) { option in
                segmentButton(for: option)
            }
        }
        .frame(height: 56)
        .background(.appWhite)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 28)
                .stroke(AppColors.primary, lineWidth: 1.5)
        )
    }

    // MARK: - Segment Button

    @ViewBuilder
    private func segmentButton(for option: Option) -> some View {
        let isSelected = option == selected

        Button {
            guard !isSelected else { return }
            withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                selected = option
            }
            onChange?(option)
        } label: {
            ZStack {
                // Sliding filled capsule — only shown under the selected segment
                if isSelected {
                    RoundedRectangle(cornerRadius: 28)
                        .fill(AppColors.primary)
                        .matchedGeometryEffect(id: "selection", in: animation)
                }

                Text(label(option))
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(isSelected ? AppColors.white : AppColors.primary)
                    .animation(.easeInOut(duration: 0.2), value: isSelected)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Preview
fileprivate enum AuthMode: Hashable, CaseIterable {
    case signUp, login
}
fileprivate enum FilterOption: Hashable, CaseIterable {
    case all, pharmacy, otc, prescription
    var title: String {
        switch self {
        case .all:          "All"
        case .pharmacy:     "Pharmacy"
        case .otc:          "OTC"
        case .prescription: "Rx"
        }
    }
}
#Preview {
    @Previewable @State var authMode: AuthMode = .signUp
    @Previewable @State var filter: FilterOption = .all

    VStack(spacing: AppSpacing.xLarge) {

        // --- Example 1: Auth switcher (matches Figma) ---
        SegmentedPicker(
            options: AuthMode.allCases,
            selected: $authMode,
            label: { $0 == .signUp ? "Sign Up" : "Log In" },
            onChange: { print("Auth mode changed to: \($0)") }
        )

        // --- Example 2: Multi-segment filter ---
        SegmentedPicker(
            options: FilterOption.allCases,
            selected: $filter,
            label: { $0.title },
            onChange: { print("Filter changed to: \($0)") }
        )
    }
    .padding(AppSpacing.large)
//    .background(AppColors.background)
}
