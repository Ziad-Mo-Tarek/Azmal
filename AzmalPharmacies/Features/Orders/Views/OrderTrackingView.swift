import SwiftUI

struct OrderTrackingView: View {
    let orderID: Int

    var body: some View {
        List(OrderStatus.allCases, id: \.self) { status in
            Label(status.rawValue.capitalized, systemImage: "circle")
        }
        .navigationTitle("Tracking #\(orderID)")
    }
}
