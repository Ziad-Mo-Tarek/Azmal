import SwiftUI

struct CategoryProductsView: View {
    let category: Category

    var body: some View {
        ProductListView(title: category.name, products: Product.mockProducts)
    }
}
