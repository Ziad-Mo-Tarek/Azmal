import SwiftUI

struct DeliveryAddressView: View {
    var body: some View {
        List(Address.mockAddresses) { address in
            AddressCard(address: address)
                .listRowSeparator(.hidden)
        }
        .navigationTitle("Delivery Address")
    }
}
