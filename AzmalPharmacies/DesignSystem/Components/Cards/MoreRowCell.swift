import SwiftUI

struct MoreRowCell: View {
    var icon: String? = nil
    var iconImage: ImageResource? = nil
    let title: LocalizedStringKey
    var isDestructive: Bool = false
    var action: (() -> Void)? = nil

    var foregroundColor: Color {
        isDestructive ? AppColors.primary : AppColors.primaryDark
    }

    var body: some View {
        Button {
            action?()
        } label: {
            HStack(spacing: AppSpacing.medium) {
                // Icon circle
                ZStack {
                    Circle()
                        .fill(foregroundColor.opacity(0.08))
                        .frame(width: 40, height: 40)
                    if let iconImage = iconImage {
                        Image(iconImage)
                    } else if let icon {
                        Image(systemName: icon)
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.primaryApp)
                    }
                }

                Text(title)
                    .appTextStyle(.bodySmall, color: isDestructive ? .red : .appDark)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(Color(.systemGray3))
            }
            .padding(.horizontal, AppSpacing.large)
            .padding(.vertical, AppSpacing.medium)
            .background(AppColors.surface)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    VStack(spacing: 10) {
        MoreRowCell(icon: "person", title: "Profile")
        MoreRowCell(icon: "heart", title: "Favorites")
        MoreRowCell(icon: "rectangle.portrait.and.arrow.right", title: "Logout", isDestructive: true)
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}
