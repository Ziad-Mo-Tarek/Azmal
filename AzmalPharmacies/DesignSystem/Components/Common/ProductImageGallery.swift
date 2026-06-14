import SwiftUI

struct ProductImageGallery: View {
    let imageUrls: [String]
    @State private var currentIndex = 0
    
    var body: some View {
        VStack(spacing: AppSpacing.medium) {
            TabView(selection: $currentIndex) {
                ForEach(imageUrls.indices, id: \.self) { index in
                    ImageLoader(urlString: imageUrls[index], contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 220)
            
            // Custom Dots indicator
            HStack(spacing: 4) {
                ForEach(imageUrls.indices, id: \.self) { index in
                    if index == currentIndex {
                        Capsule()
                            .fill(AppColors.primary)
                            .frame(width: 16, height: 6)
                    } else {
                        Circle()
                            .strokeBorder(AppColors.primary, lineWidth: 1)
                            .frame(width: 6, height: 6)
                    }
                }
            }
        }
    }
}
