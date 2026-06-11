import SwiftUI

struct AppNavigationBar<TrailingContent: View>: View {
    let title: String?
    let showBackButton: Bool
    let backAction: (() -> Void)?
    var searchBinding: Binding<String>?
    var searchPlaceholder: String
    var onSearchSubmit: (() -> Void)?
    @ViewBuilder let trailingContent: TrailingContent
    
    @Environment(\.dismiss) private var dismiss
    
    init(
        title: String? = nil,
        showBackButton: Bool = true,
        backAction: (() -> Void)? = nil,
        searchBinding: Binding<String>? = nil,
        searchPlaceholder: String = "Search your Medicine & Healthcare Products",
        onSearchSubmit: (() -> Void)? = nil,
        @ViewBuilder trailingContent: () -> TrailingContent = { EmptyView() }
    ) {
        self.title = title
        self.showBackButton = showBackButton
        self.backAction = backAction
        self.searchBinding = searchBinding
        self.searchPlaceholder = searchPlaceholder
        self.onSearchSubmit = onSearchSubmit
        self.trailingContent = trailingContent()
    }
    
    var body: some View {
        VStack(spacing: 16) {
            // Top Row
            HStack(spacing: 16) {
                if showBackButton {
                    Button(action: {
                        if let backAction = backAction {
                            backAction()
                        } else {
                            dismiss()
                        }
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 28, weight: .semibold))
                            .foregroundColor(.appWhite)
                            .frame(width: 28, height: 28, alignment: .leading)
                    }
                }
                
                if let title = title {
                    Text(title)
                        .appTextStyle(.headingSmall, color: .appWhite, weight: .semibold)
                    Spacer()
                    trailingContent
                } else if let searchBinding = searchBinding {
                    // Search bar in top row
                    CustomSearchBar(text: searchBinding, placeholder: LocalizedStringKey(searchPlaceholder), onSubmit: onSearchSubmit)
                } else {
                    Spacer()
                }
            }
            
            // Second Row for Search Bar (if title is present)
            if title != nil, let searchBinding = searchBinding {
                CustomSearchBar(text: searchBinding, placeholder: LocalizedStringKey(searchPlaceholder), onSubmit: onSearchSubmit)
            }
        }
        .padding(.horizontal, AppSpacing.medium)
        .padding(.top, 20)
        .padding(.bottom, 16)
        .background(
            AppColors.primary
                .ignoresSafeArea(edges: .top)
        )
        .customCornerRadius(24, corners: [.bottomLeft, .bottomRight])
    }
}

#Preview {
    VStack(spacing: 20) {
        // Variant 1: Search only
        AppNavigationBar(
            title: nil,
            showBackButton: false,
            searchBinding: .constant("")
        )
        
        // Variant 2: Back + Search
        AppNavigationBar(
            title: nil,
            showBackButton: true,
            searchBinding: .constant(""),
            searchPlaceholder: "Search Your Products...."
        )
        
        // Variant 3: Back + Title + Trailing + Search
        AppNavigationBar(
            title: "Offers",
            showBackButton: true,
            searchBinding: .constant(""),
            searchPlaceholder: "Search your Medicine & Healthcare Products"
        ) {
            HStack(spacing: 8) {
                Button(action: {}) {
                    Image(systemName: "line.3.horizontal.decrease.circle.fill")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .foregroundColor(.white)
                }
                Button(action: {}) {
                    Image(systemName: "arrow.up.arrow.down.circle.fill")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .foregroundColor(.white)
                }
            }
        }
        
        // Variant 4: Back + Title
        AppNavigationBar(
            title: "Prescription",
            showBackButton: true
        )
        
        Spacer()
    }
//    .background(Color(UIColor.systemGroupedBackground))
//    .ignoresSafeArea(edges: .top)
    .padding(.horizontal)
}
