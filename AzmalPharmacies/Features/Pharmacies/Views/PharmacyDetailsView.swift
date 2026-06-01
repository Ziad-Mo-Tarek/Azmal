import SwiftUI

struct PharmacyDetailsView: View {
    let pharmacyID: Int

    var body: some View {
        VStack(spacing: AppSpacing.large) {
            PharmacyCard(pharmacy: Pharmacy.mockPharmacies.first ?? Pharmacy(id: pharmacyID, name: "Pharmacy", address: "", phone: nil, distanceText: nil))
            PrimaryButton(title: "Call Pharmacy", systemImage: "phone") {}
        }
        .appScreenPadding()
        .background(AppColors.background)
        .navigationTitle("Pharmacy")
    }
}
