import SwiftUI

struct HomeView: View {
    @State private var viewModel = HomeViewModel()
    @Environment(AppRouter.self) private var router

    private let columns = [
        GridItem(.flexible(), spacing: AppSpacing.medium),
        GridItem(.flexible(), spacing: AppSpacing.medium)
    ]

    var body: some View {
        @Bindable var viewModel = viewModel

        ScrollView {
            VStack(alignment: .leading, spacing: AppSpacing.large) {
                header
                SearchField(text: $viewModel.searchText)
                PromotionalBannerView()

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

    private var header: some View {
        HStack {
            VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
                Text("Deliver to")
                    .font(AppTypography.caption)
                    .foregroundStyle(AppColors.textSecondary)
                Text("Current location")
                    .font(AppTypography.headline)
            }
            Spacer()
            AppIconButton(systemImage: "bell") {}
        }
    }
}
