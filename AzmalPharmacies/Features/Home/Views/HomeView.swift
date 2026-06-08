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
            VStack(alignment: .leading, spacing: AppSpacing.large) {
                header
                searchText
                
                HomeBanner(slides: viewModel.banners, index: $viewModel.selectedBannerIndex)

                SectionHeader(title: "Featured Products", actionTitle: "View all") {
                    router.push(.productDetails(id: 1))
                }

                if let errorMessage = viewModel.productsErrorMessage {
                    VStack(alignment: .center, spacing: AppSpacing.medium) {
                        Text("Failed to load products")
                            .font(AppTypography.headline)
                            .foregroundStyle(AppColors.textPrimary)
                        Text(errorMessage)
                            .font(AppTypography.body)
                            .foregroundStyle(AppColors.textSecondary)
                            .multilineTextAlignment(.center)
                        SecondaryButton(title: "Try Again") {
                            Task {
                                await viewModel.loadHomeProducts()
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(AppColors.primary.opacity(0.05))
                    .cornerRadius(AppRadius.medium)
                } else if viewModel.isLoadingProducts && viewModel.featuredProducts.isEmpty {
                    HStack {
                        Spacer()
                        LoadingView()
                            .frame(height: 150)
                        Spacer()
                    }
                } else {
                    LazyVGrid(columns: columns, spacing: AppSpacing.medium) {
                        ForEach(viewModel.featuredProducts) { product in
                            ProductCard(product: product) {
                                router.push(.productDetails(id: product.id))
                            }
                        }
                    }
                }

                SectionHeader(title: "Nearby Pharmacies")
                ForEach(viewModel.pharmacies) { pharmacy in
                    PharmacyCard(pharmacy: pharmacy)
                        .onTapGesture {
                            router.push(.pharmacyDetails(id: pharmacy.id))
                        }
                }
            }
            .appScreenPadding()
            .padding(.vertical, AppSpacing.large)
        }
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
    
}


#Preview {
    HomeView(viewModel: .init())
        .environment(AppRouter())
        .environment(DependencyContainer())
}
