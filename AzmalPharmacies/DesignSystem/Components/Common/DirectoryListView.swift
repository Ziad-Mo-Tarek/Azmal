import SwiftUI

struct DirectoryListView<Item: Identifiable, Cell: View>: View {
    @Environment(AppRouter.self) private var router
    let title: String
    let searchPlaceholder: String
    let items: [Item]
    let columns: [GridItem]
    let cellContent: (Item) -> Cell
    
    @State private var searchText = ""

    var body: some View {
        VStack(spacing: 0) {
            AppNavigationBar(
                title: nil,
                showBackButton: true,
                backAction: { router.pop() },
                searchBinding: $searchText,
                searchPlaceholder: searchPlaceholder,
                onSearchSubmit: {
                    // Handle search if needed
                }
            )
            .background(AppColors.primary)
            
            ScrollView {
                VStack(alignment: .leading, spacing: AppSpacing.large) {
                    Text(title)
                        .appTextStyle(.headingSmall, color: .black, weight: .bold)
                        .padding(.horizontal, AppSpacing.large)
                        .padding(.top, AppSpacing.xLarge)
                    
                    LazyVGrid(columns: columns, spacing: AppSpacing.large) {
                        ForEach(items) { item in
                            cellContent(item)
                        }
                    }
                    .padding(.horizontal, AppSpacing.large)
                    .padding(.bottom, AppSpacing.large)
                }
            }
            
            Spacer(minLength: 0)
        }
        .background(AppColors.background)
        .toolbar(.hidden, for: .navigationBar)
    }
}
