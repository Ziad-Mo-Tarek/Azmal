import SwiftUI

struct ProductSearchView: View {
    @State private var searchText = ""

    var body: some View {
        VStack(spacing: AppSpacing.large) {
            SearchField(text: $searchText)
            ProductListView(title: "Search", products: Product.mockProducts)
        }
        .navigationTitle("Search")
    }
}
