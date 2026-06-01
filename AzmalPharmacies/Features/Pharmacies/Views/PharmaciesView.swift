import SwiftUI

struct PharmaciesView: View {
    var body: some View {
        List(Pharmacy.mockPharmacies) { pharmacy in
            PharmacyCard(pharmacy: pharmacy)
                .listRowSeparator(.hidden)
        }
        .navigationTitle("Pharmacies")
    }
}
