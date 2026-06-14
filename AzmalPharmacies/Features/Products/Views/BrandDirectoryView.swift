import SwiftUI

struct BrandDirectoryView: View {
    struct DummyBrand: Identifiable {
        let id = UUID()
        let name: String
    }
    
    let brands: [DummyBrand] = (1...12).map { DummyBrand(name: "Brand \($0)") }
    
    private let columns = [
        GridItem(.flexible(), spacing: AppSpacing.medium),
        GridItem(.flexible(), spacing: AppSpacing.medium)
    ]
    
    var body: some View {
        DirectoryListView(
            title: "Shop By Brand",
            searchPlaceholder: "Search Your Products....",
            items: brands,
            columns: columns
        ) { brand in
            RoundedRectangle(cornerRadius: AppRadius.medium)
                .fill(AppColors.surface)
                .frame(height: 80)
                .shadow(color: AppColors.textSecondary.opacity(0.1), radius: 4, x: 0, y: 2)
                .overlay(
                    Image(systemName: "tag.fill")
                        .foregroundColor(AppColors.textSecondary)
                )
        }
    }
}

#Preview {
    BrandDirectoryView()
        .environment(AppRouter())
}
