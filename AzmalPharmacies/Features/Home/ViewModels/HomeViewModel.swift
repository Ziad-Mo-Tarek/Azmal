import Foundation
import Observation

@Observable
final class HomeViewModel {
    var searchText = ""
    var featuredProducts: [Product] = Product.mockProducts
    var pharmacies: [Pharmacy] = Pharmacy.mockPharmacies
}
