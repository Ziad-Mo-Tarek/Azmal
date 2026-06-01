import SwiftUI

struct OrdersView: View {
    @Environment(AppRouter.self) private var router

    var body: some View {
        List(Order.mockOrders) { order in
            OrderCard(order: order)
                .onTapGesture {
                    router.push(.orderDetails(id: order.id))
                }
                .listRowSeparator(.hidden)
        }
        .navigationTitle("Orders")
    }
}
