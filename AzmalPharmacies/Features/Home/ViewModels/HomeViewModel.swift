import Foundation
import Observation

@Observable
final class HomeViewModel {
    var searchText = ""
    var featuredProducts: [Product] = []
    var pharmacies: [Pharmacy] = Pharmacy.mockPharmacies
    var isLoadingProducts = false
    var productsErrorMessage: String?

    // 1. Decoupling: The ViewModel should not know about HTTP requests, URLs, or API clients.
    // It depends only on the Domain Repository contract (ProductRepositoryProtocol).
    private let productRepository: ProductRepositoryProtocol

    init(
        // We inject the repository, defaulting to our live container's instance
        productRepository: ProductRepositoryProtocol = DependencyContainer.live.productRepository
    ) {
        self.productRepository = productRepository
    }

    @MainActor
    func loadHomeProducts() async {
        isLoadingProducts = true
        productsErrorMessage = nil

        do {
            // 2. Clean Architecture in Action: 
            // We just ask the repository for Domain Entities ([Product]).
            // The Repository internally coordinates with the APIService to fetch DTOs,
            // and uses the ProductMapper to return clean Swift structs.
            // We got rid of the manual decoding, mapping, and endpoint construction here!
            featuredProducts = try await productRepository.featuredProducts()
        } catch {
            productsErrorMessage = error.localizedDescription
        }

        isLoadingProducts = false
    }
}
