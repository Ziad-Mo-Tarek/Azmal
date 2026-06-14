import SwiftUI

struct CategoryDirectoryView: View {
    struct DummyCategory: Identifiable {
        let id = UUID()
        let name: String
    }
    
    let categories: [DummyCategory] = [
        .init(name: "Medications"),
        .init(name: "Skincare"),
        .init(name: "Haircare"),
        .init(name: "Mom & Baby"),
        .init(name: "Body Care"),
        .init(name: "Makeup")
    ]
    
    private let columns = [
        GridItem(.flexible(), spacing: AppSpacing.medium),
        GridItem(.flexible(), spacing: AppSpacing.medium),
        GridItem(.flexible(), spacing: AppSpacing.medium)
    ]
    
    var body: some View {
        DirectoryListView(
            title: "Shop By Category",
            searchPlaceholder: "Search Your Products....",
            items: categories,
            columns: columns
        ) { category in
            CategoryCell(title: category.name, imageURL: nil, imageSize: 100)
        }
    }
}

#Preview {
    CategoryDirectoryView()
        .environment(AppRouter())
}
