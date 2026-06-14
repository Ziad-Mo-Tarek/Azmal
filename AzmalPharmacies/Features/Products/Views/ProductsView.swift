import SwiftUI

struct ProductsView: View {
    @State private var viewModel = ProductsViewModel()
    @State private var quantities: [Int: Int] = [:]
    @Environment(AppRouter.self) private var router
    @State private var showSortSheet = false
    @State private var showFilterSheet = false
    
    private let columns = [
        GridItem(.flexible(), spacing: AppSpacing.medium),
        GridItem(.flexible(), spacing: AppSpacing.medium)
    ]
    
    var body: some View {
        @Bindable var viewModel = viewModel
        
        VStack(spacing: 0) {
            // Header with Search Bar
            AppNavigationBar(
                title: nil,
                showBackButton: true,
                backAction: {
                    router.popToRoot()
                },
                searchBinding: $viewModel.searchText,
                searchPlaceholder: "Search Your Products....",
                onSearchSubmit: { viewModel.performSearch() }
            ) {
                if viewModel.isShowingResults {
                    HStack(spacing: 8) {
                        Button(action: {
                            showFilterSheet = true
                        }){
                            Image(.filterICon)
                                .padding(11)
                                .background(.appWhite)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                        }
                    }
                }
            }
            .background(AppColors.primary)
//            .padding(.top, 100)
            // Content
            if viewModel.isShowingResults {
                searchResults
            } else {
                recentSearches
            }
            
            Spacer(minLength: 0)
        }
        .background(AppColors.background)
        .toolbar(.hidden, for: .navigationBar)
        .sheet(isPresented: $showSortSheet) {
            ProductsSortView()
        }
        .sheet(isPresented: $showFilterSheet) {
            FilterView()
        }
    }
    
    // MARK: - Search Results
    private var searchResults: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppSpacing.medium) {
                
                // Results Header
                HStack {
                    Text("Showing Results For \"\(viewModel.searchText)\"")
                        .appTextStyle(.headingSmall, color: .appDark)
                    
                    Spacer()
                    
                    Button(action: {
                        showSortSheet = true
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "arrow.up.arrow.down")
                                .font(.system(size: 14))
                                .foregroundColor(AppColors.primary)
                            Text("Sort By")
                                .appTextStyle(.bodySemiboldTiny, color: AppColors.primary)
                        }
                    }
                }
                .padding(.horizontal, AppSpacing.medium)
                .padding(.top, AppSpacing.medium)
                
                // Grid of Products
                LazyVGrid(columns: columns, spacing: AppSpacing.medium) {
                    ForEach(viewModel.products) { product in
                        ProductCell(
                            title: product.name,
                            imageURL: product.imageURL?.absoluteString,
                            currentPrice: "EGP \(product.price)",
                            originalPrice: nil,
                            badge: .none,
                            isFavorite: false,
                            cartQuantity: quantities[product.id, default: 0],
                            onFavoriteToggle: {},
                            onAdd: { quantities[product.id, default: 0] += 1 },
                            onRemove: {
                                if let qty = quantities[product.id], qty > 1 {
                                    quantities[product.id] = qty - 1
                                } else {
                                    quantities.removeValue(forKey: product.id)
                                }
                            }
                        )
                        .onTapGesture {
                            router.push(.productDetails(id: product.id))
                        }
                    }
                }
                .appScreenPadding()
                .padding(.bottom, AppSpacing.large)
            }
        }
    }
    
    // MARK: - Recent Searches
    private var recentSearches: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text("Recent search")
                        .appTextStyle(.headingSmall, color: .appDark)
                    
                    Spacer()
                    
                    if !viewModel.recentSearches.isEmpty {
                        Button("Clear All") {
                            withAnimation {
                                viewModel.clearRecentSearches()
                            }
                        }
                        .appTextStyle(.bodySmall, color: AppColors.primary, weight: .semibold)
                    }
                    
                    if viewModel.isShowingResults {
                        HStack(spacing: 4){
                            Image(systemName: "arrow.up.arrow.down")
                                .resizable()
                                .foregroundStyle(.primaryApp)
                                .frame(width: 16, height: 16)
                            Text(LocalizedStringKey("Sort By"))
                                .appTextStyle(.bodySemiboldSmall, color: .primaryApp, weight: .semibold)
                        }
                    }
                }
                .padding(.horizontal, AppSpacing.medium)
                .padding(.top, AppSpacing.large)
                .padding(.bottom, AppSpacing.medium)
                
                ForEach(viewModel.recentSearches, id: \.self) { search in
                    RecentSearchRow(
                        text: search,
                        onTap: { viewModel.selectRecentSearch(search) },
                        onRemove: { 
                            withAnimation {
                                viewModel.removeRecentSearch(search) 
                            }
                        }
                    )
                }
            }
        }
    }
}

// MARK: - RecentSearchRow
struct RecentSearchRow: View {
    let text: String
    let onTap: () -> Void
    let onRemove: () -> Void
    
    var body: some View {
        HStack(spacing: AppSpacing.medium) {
            Image(systemName: "clock.arrow.circlepath")
                .foregroundColor(AppColors.textSecondary)
                .font(.system(size: 18))
            
            Text(text)
                .appTextStyle(.bodySmall, color: AppColors.textSecondary)
                .lineLimit(1)
            
            Spacer()
            
            Button(action: onRemove) {
                Image(systemName: "xmark")
                    .foregroundColor(AppColors.textSecondary)
                    .font(.system(size: 16))
            }
        }
        .padding(.horizontal, AppSpacing.medium)
        .padding(.vertical, 12)
        .contentShape(Rectangle())
        .onTapGesture(perform: onTap)
    }
}

#Preview {
    ProductsView()
        .environment(AppRouter())
        .environment(DependencyContainer())
}
