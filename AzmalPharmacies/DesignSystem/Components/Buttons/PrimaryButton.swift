import SwiftUI

enum AppButtonStyle: Equatable {
    case primary
    case secondary
}

struct PrimaryButton: View {
    let title: String
    var systemImage: String?
    var isLoading = false
    var isDisabled = false
    var action: () -> Void

    var body: some View {
        AppButton(
            title: title,
            style: .primary,
            systemImage: systemImage,
            isLoading: isLoading,
            isDisabled: isDisabled,
            action: action
        )
    }
}

struct AppButton: View {
    let title: String
    var style: AppButtonStyle = .primary
    var systemImage: String?
    var isLoading = false
    var isDisabled = false
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: AppSpacing.small) {
                if isLoading {
                    ProgressView()
                        .tint(foregroundColor)
                } else if let systemImage {
                    Image(systemName: systemImage)
                }

                Text(title)
                    .font(AppTypography.title)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 60)
            .foregroundStyle(foregroundColor)
            .background(backgroundColor)
            .overlay {
                RoundedRectangle(cornerRadius: 25)
                    .stroke(borderColor, lineWidth: borderWidth)
            }
            .clipShape(RoundedRectangle(cornerRadius: 25))
        }
        .buttonStyle(.plain)
        .disabled(isLoading || isDisabled)
    }

    private var backgroundColor: Color {
        if isDisabled {
            return style == .primary ? AppColors.disabledButton : AppColors.white
        }

        return style == .primary ? AppColors.primary : AppColors.white
    }

    private var foregroundColor: Color {
        if isDisabled {
            return style == .primary ? AppColors.white : AppColors.disabledButton
        }

        return style == .primary ? AppColors.white : AppColors.primary
    }

    private var borderColor: Color {
        if isDisabled {
            return style == .secondary ? AppColors.disabledButton : .clear
        }

        return style == .secondary ? AppColors.primary : .clear
    }

    private var borderWidth: CGFloat {
        style == .secondary ? 1 : 0
    }
}

#Preview {
    VStack(spacing: 20) {
        AppButton(title: "Continue") {}
        AppButton(title: "Cancel", style: .secondary) {}
        AppButton(title: "Continue", isDisabled: true) {}
        AppButton(title: "Continue", isLoading: true) {}
        AppButton(title: "Continue", systemImage: "star") {}
    }
    .padding()
}
