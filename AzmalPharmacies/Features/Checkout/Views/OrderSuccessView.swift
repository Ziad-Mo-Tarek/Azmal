import SwiftUI

struct OrderSuccessView: View {
    var body: some View {
        EmptyStateView(title: "Order placed", message: "Your order is being prepared.", systemImage: "checkmark.circle")
            .navigationTitle("Success")
    }
}
