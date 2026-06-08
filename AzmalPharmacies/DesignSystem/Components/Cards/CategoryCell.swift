import SwiftUI

struct CategoryCell: View {
    let title: String
    let imageURL: URL?
    var imageSize: CGFloat = 100
    var action: (() -> Void)? = nil
    
    var body: some View {
        Button {
            action?()
        } label: {
            VStack(spacing: AppSpacing.medium) {
                // Image Card Container
                ZStack {
                    AppColors.surface
                    
                    ImageLoader(
                        urlString: imageURL?.absoluteString ?? AppConstants.randomeImage,
                        contentMode: .fill
                    )
//                    .cornerRadius(10)
//                    .padding(AppSpacing.medium)
                }
                .frame(width: imageSize, height: imageSize)
                .clipShape(RoundedRectangle(cornerRadius: 16)) // Assuming a larger radius like 18-20 based on design
                .shadow(color: .appDark.opacity(0.25), radius: 7, x: 0, y: 4)
                
                // Category Title
                Text(title)
                    .appTextStyle(.bodySmall, color: .appDark)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ZStack {
        AppColors.background.ignoresSafeArea()
        
        HStack(spacing: AppSpacing.xLarge) {
            CategoryCell(
                title: "Medications",
                imageURL: nil,
                imageSize: 120
            )
            
            CategoryCell(
                title: "Vitamins",
                imageURL: nil,
                imageSize: 120
            )
        }
        .padding()
    }
}
