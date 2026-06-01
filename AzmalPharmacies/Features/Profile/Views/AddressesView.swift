import SwiftUI

struct AddressesView: View {
    var body: some View {
        List(Address.mockAddresses) { address in
            AddressCard(address: address)
                .listRowSeparator(.hidden)
        }
        .navigationTitle("Addresses")
    }
}
