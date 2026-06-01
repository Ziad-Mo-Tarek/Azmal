import SwiftUI

struct ProductListView: View {
    let title: String
    let products: [Product]
    @Environment(AppRouter.self) private var router

    private let columns = [
        GridItem(.flexible(), spacing: AppSpacing.medium),
        GridItem(.flexible(), spacing: AppSpacing.medium)
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: AppSpacing.medium) {
                ForEach(products) { product in
                    ProductCard(product: product) {
                        router.push(.productDetails(id: product.id))
                    }
                }
            }
            .appScreenPadding()
            .padding(.vertical, AppSpacing.large)
        }
        .background(AppColors.background)
        .navigationTitle(title)
    }
}
