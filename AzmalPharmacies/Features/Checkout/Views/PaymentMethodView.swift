import SwiftUI

struct PaymentMethodView: View {
    var body: some View {
        List {
            Label("Cash on delivery", systemImage: "banknote")
            Label("Card", systemImage: "creditcard")
        }
        .navigationTitle("Payment")
    }
}
