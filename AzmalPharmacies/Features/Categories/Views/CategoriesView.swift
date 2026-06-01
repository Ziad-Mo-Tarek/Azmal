import SwiftUI

struct CategoriesView: View {
    private let categories = Category.mockCategories

    var body: some View {
        List(categories) { category in
            NavigationLink {
                CategoryProductsView(category: category)
            } label: {
                Label(category.name, systemImage: "pills")
            }
        }
        .navigationTitle("Categories")
    }
}
