import SwiftUI

struct HomeView: View {
    @State var viewModel: HomeViewModel
    @Environment(AppRouter.self) private var router
    @Environment(DependencyContainer.self) private var dependencies
    
    private let columns = [
        GridItem(.flexible(), spacing: AppSpacing.medium),
        GridItem(.flexible(), spacing: AppSpacing.medium)
    ]

    var body: some View {
        @Bindable var viewModel = viewModel
        
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                header
                    .appScreenPadding()
                    .padding(.bottom, 21)
                
                searchText
                    .appScreenPadding()
                    .padding(.bottom, 20)
                
                HomeBanner(slides: viewModel.banners, index: $viewModel.selectedBannerIndex)
                    .appScreenPadding()
                    .padding(.bottom, 24)
                // Shop by Category
                sectionContainer(title: "Shop by Category") {
                    HStack(spacing: AppSpacing.medium) {
                        CategoryCell(title: "Medications", imageURL: nil, imageSize: 80)
                        CategoryCell(title: "Skincare", imageURL: nil, imageSize: 80)
                        CategoryCell(title: "Haircare", imageURL: nil, imageSize: 80)
                        CategoryCell(title: "mom & baby", imageURL: nil, imageSize: 80)
                    }
                }
                
                // New Arrival
                sectionContainer(title: "New Arrival") {
                    horizontalProductList(badge: .none, currentPrice: "EGP 1000", originalPrice: nil)
                }

                // Limited Offers
                sectionContainer(title: "Limited Offers") {
                    horizontalProductList(badge: .discount("20% Discount"), currentPrice: "EGP 800", originalPrice: "EGP 1000")
                }

                // Trending
                sectionContainer(title: "Trending") {
                    horizontalProductList(badge: .bestSeller, currentPrice: "EGP 1000", originalPrice: nil)
                }
                
                // Shop by Brand
                sectionContainer(title: "Shop by Brand") {
                    LazyHGrid(
                        rows: [
                            GridItem(.fixed(60), spacing: AppSpacing.medium),
                            GridItem(.fixed(60), spacing: AppSpacing.medium)
                        ],
                        spacing: AppSpacing.medium
                    ) {
                        ForEach(0..<8) { _ in
                            RoundedRectangle(cornerRadius: AppRadius.medium)
                                .fill(AppColors.surface)
                                .frame(width: 100, height: 60)
                                .shadow(color: AppColors.textSecondary.opacity(0.1), radius: 4, x: 0, y: 2)
                                .overlay(
                                    Image(systemName: "tag.fill")
                                        .foregroundColor(AppColors.textSecondary)
                                )
                        }
                    }
                }
                
            }
            .padding(.bottom, AppSpacing.large)
        }
        .scrollIndicators(.hidden)
        .background(AppColors.background)
        .navigationTitle("Azmal Pharmacies")
        .refreshable {
            await viewModel.loadHomeProducts()
        }
        .task {
            await viewModel.loadHomeProducts()
        }
    }
    
    private var greeting: String {
        let calendar = Calendar.current
        
        var egyptCalendar = calendar
        egyptCalendar.timeZone = TimeZone(identifier: "Africa/Cairo") ?? .current
        
        let hour = egyptCalendar.component(.hour, from: Date())

        switch hour {
        case 5..<12:
            return "Good Morning"
        case 12..<17:
            return "Good Afternoon"
        case 17..<21:
            return "Good Evening"
        default:
            return "Good Night"
        }
    }

    private var header: some View {
        HStack(spacing: 12){
            Image(.logoCircle)
                .resizable()
                .frame(width: 52, height: 52)
            VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                Text(LocalizedStringKey("\(greeting)"))
                    .appTextStyle(.bodyLarge, weight: .semibold)
                Text("Hi \(dependencies.authSession.currentUser?.name ?? "Ziad")")
                    .appTextStyle(.bodySmall)
            }
            Spacer()
            Button {
                
            } label: {
                Image(.notificationIcon)
            }
            
        }
    }
    
    private var searchText: some View {
        CustomSearchBar(text: $viewModel.searchText, placeholder: "Search your Medicine & Healthcare Products")
    }
    
    @ViewBuilder
    private func sectionContainer<Content: View>(
        title: String,
        action: @escaping () -> Void = {},
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(spacing: AppSpacing.medium) {
            SectionHeader(title: title, actionTitle: "View All >", action: action)
                .appScreenPadding()
            ScrollView(.horizontal, showsIndicators: false) {
                content()
                    .appScreenPadding()
                    .padding(.bottom, 32)
            }
        }
    }
    
    @ViewBuilder
    private func horizontalProductList(badge: ProductBadge?, currentPrice: String, originalPrice: String?) -> some View {
        HStack(spacing: AppSpacing.medium) {
            ForEach(0..<4) { _ in
                ProductCell(
                    title: "Cerave daily moisturizing lotion for normal to dry ski...",
                    imageURL: nil,
                    currentPrice: currentPrice,
                    originalPrice: originalPrice,
                    badge: badge,
                    isFavorite: false,
                    onFavoriteToggle: {},
                    onAddToCart: {}
                )
            }
        }
    }
}


#Preview {
    HomeView(viewModel: .init())
        .environment(AppRouter())
        .environment(DependencyContainer())
}
