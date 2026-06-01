import SwiftUI

struct OrderDetailsView: View {
    let orderID: Int
    @Environment(AppRouter.self) private var router

    var body: some View {
        VStack(spacing: AppSpacing.large) {
            OrderCard(order: Order.mockOrders.first ?? Order.mockOrders[0])
            PrimaryButton(title: "Track Order", systemImage: "location") {
                router.push(.orderTracking(id: orderID))
            }
        }
        .appScreenPadding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(AppColors.background)
        .navigationTitle("Order Details")
    }
}
