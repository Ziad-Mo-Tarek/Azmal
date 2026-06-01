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

                LazyVGrid(columns: columns, spacing: AppSpacing.medium) {
                    ForEach(viewModel.featuredProducts) { product in
                        ProductCard(product: product) {
                            router.push(.productDetails(id: product.id))
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
