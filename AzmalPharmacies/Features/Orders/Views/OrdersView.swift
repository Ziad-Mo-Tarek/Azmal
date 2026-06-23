import SwiftUI

enum OrderFilter: String, CaseIterable {
    case all = "All"
    case active = "Active"
    case history = "History"
}

struct OrdersView: View {
    @Environment(AppRouter.self) private var router
    @State private var selectedFilter: OrderFilter = .all
    var orders: [Order] = Order.mockOrders

    var filteredOrders: [Order] {
        switch selectedFilter {
        case .all:
            return orders
        case .active:
            return orders.filter {
                $0.status != .delivered && $0.status != .cancelled
            }
        case .history:
            return orders.filter {
                $0.status == .delivered || $0.status == .cancelled
            }
        }
    }

    private var emptyStateTitle: String {
        switch selectedFilter {
        case .all:
            return "No Orders Yet"
        case .active:
            return "No Active Orders"
        case .history:
            return "No Past Orders"
        }
    }

    private var emptyStateMessage: String {
        switch selectedFilter {
        case .all:
            return "You haven't placed any orders yet. Explore our products and make your first order!"
        case .active:
            return "You don't have any active orders right now."
        case .history:
            return "You don't have any order history yet."
        }
    }

    private var emptyStateIcon: String {
        switch selectedFilter {
        case .all:
            return "cart"
        case .active:
            return "clock"
        case .history:
            return "tray"
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            // ── Navigation Bar ──
            AppNavigationBar(
                title: "My Orders",
                showBackButton: true,
                backAction: { router.pop() }
            )
            .background(AppColors.primary)

            // ── Filter Chips ──
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: AppSpacing.medium) {
                    ForEach(OrderFilter.allCases, id: \.self) { filter in
                        Button {
                            withAnimation(.spring(response: 0.25, dampingFraction: 0.85)) {
                                selectedFilter = filter
                            }
                        } label: {
                            Text(filter.rawValue)
                                .appTextStyle(.bodyMedium, color: selectedFilter == filter ? AppColors.white : AppColors.primary, weight: .semibold)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 24)
                                .background(selectedFilter == filter ? AppColors.primary : AppColors.white)
                                .clipShape(Capsule())
                                .overlay(
                                    Capsule()
                                        .stroke(AppColors.primary, lineWidth: 1)
                                )
                        }
                    }
                }
                .padding(.horizontal, AppSpacing.large)
                .padding(.vertical, AppSpacing.large)
            }
            
            // ── Orders List ──
            Group {
                if filteredOrders.isEmpty {
                    VStack {
                        Spacer()
                        EmptyStateView(
                            title: emptyStateTitle,
                            message: emptyStateMessage,
                            systemImage: emptyStateIcon
                        )
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView(showsIndicators: false) {
                        LazyVStack(spacing: AppSpacing.large) {
                            ForEach(filteredOrders) { order in
                                OrdersCell(order: order) {
                                    router.push(.orderDetails(id: order.id))
                                }
                            }
                        }
                        .padding(AppSpacing.large)
                    }
                }
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

// MARK: - Previews

#Preview("Populated State") {
    NavigationStack {
        OrdersView()
            .environment(AppRouter())
    }
}

#Preview("Empty State") {
    NavigationStack {
        OrdersView(orders: [])
            .environment(AppRouter())
    }
}
