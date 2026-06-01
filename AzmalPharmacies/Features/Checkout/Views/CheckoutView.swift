import SwiftUI

struct CheckoutView: View {
    @Environment(AppRouter.self) private var router

    var body: some View {
        List {
            Section("Delivery") {
                NavigationLink("Address", destination: DeliveryAddressView())
            }
            Section("Payment") {
                NavigationLink("Payment Method", destination: PaymentMethodView())
            }
            Section("Summary") {
                OrderSummaryView()
            }
            PrimaryButton(title: "Place Order", systemImage: "checkmark.circle") {
                router.push(.orderDetails(id: 1))
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
        }
        .navigationTitle("Checkout")
    }
}
