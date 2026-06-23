import SwiftUI

struct SingleOrderView: View {
    let orderID: Int
    @Environment(AppRouter.self) private var router

    var order: Order {
        Order.mockOrders.first(where: { $0.id == orderID }) ?? Order.mockOrders[0]
    }

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy - h:mm a"
        return formatter
    }()

    // MARK: - Price Calculations
    var subtotal: Decimal {
        let sum = order.items.reduce(0) { $0 + $1.subtotal }
        return sum > 0 ? sum : order.total
    }

    var deliveryFee: Decimal {
        return 20
    }

    var discount: Decimal {
        let calculatedTotal = subtotal + deliveryFee
        if calculatedTotal > order.total {
            return calculatedTotal - order.total
        } else {
            return 0
        }
    }

    var datePrefixText: String {
        switch order.status {
        case .delivered: return "Delivered On :"
        case .cancelled: return "Cancelled On :"
        default: return "Ordered On :"
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            // ── Navigation Bar ──
            AppNavigationBar(
                title: "Order Details",
                showBackButton: true,
                backAction: { router.pop() }
            )
            .background(AppColors.primary)

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    
                    // ── Order Information ──
                    orderInformationSection
                    
                    sectionSeparator
                    
                    // ── Order Items ──
                    orderItemsSection
                    
                    sectionSeparator
                    
                    // ── Price Summary ──
                    priceSummarySection
                    
                    sectionSeparator
                    
                    // ── Delivery Address ──
                    deliveryAddressSection
                    
                    sectionSeparator
                    
                    // ── Payment Method ──
                    paymentMethodSection
                }
            }
            .background(AppColors.white)

            // ── Bottom Action Button ──
            bottomActionButton
        }
        .toolbar(.hidden, for: .navigationBar)
        .background(AppColors.white.ignoresSafeArea())
    }

    // MARK: - Section Separator
    private var sectionSeparator: some View {
        AppColors.background
            .frame(height: 8)
    }

    // MARK: - Reusable Functions

    @ViewBuilder
    private func sectionContainer(title: String, @ViewBuilder content: () -> some View) -> some View {
        VStack(alignment: .leading, spacing: AppSpacing.medium) {
            Text(title)
                .appTextStyle(.headingSmall, color: .appDark, weight: .semibold)
                .padding(.top, AppSpacing.large)

            content()
                .padding(.bottom, AppSpacing.large)
        }
        .padding(.horizontal, AppSpacing.large)
    }

    @ViewBuilder
    private func infoRowText(icon: String, title: String, value: String) -> some View {
        HStack(spacing: AppSpacing.medium) {
            Image(systemName: icon)
                .foregroundStyle(AppColors.primary)
                .font(.system(size: 18))
                .frame(width: 24)
            
            HStack(spacing: 4) {
                Text(title)
                    .appTextStyle(.bodyMedium, color: .appDark, weight: .medium)
                Text(value)
                    .appTextStyle(.bodyMedium, color: .gray)
            }
        }
    }

    @ViewBuilder
    private func infoRow(icon: String, iconSize: CGFloat = 18, @ViewBuilder content: () -> some View) -> some View {
        HStack(alignment: .top, spacing: AppSpacing.medium) {
            Image(systemName: icon)
                .foregroundStyle(AppColors.primary)
                .font(.system(size: iconSize))
                .frame(width: 24)
            
            content()
        }
    }

    @ViewBuilder
    private func summaryRow(title: String, value: String, isDiscount: Bool = false) -> some View {
        HStack {
            Text(title)
                .appTextStyle(.bodyMedium, color: isDiscount ? AppColors.primary : .gray)
            Spacer()
            Text(value)
                .appTextStyle(.bodyMedium, color: isDiscount ? AppColors.primary : .appDark, weight: .bold)
        }
    }

    // MARK: - Sections

    private var orderInformationSection: some View {
        sectionContainer(title: "Order Information") {
            VStack(alignment: .leading, spacing: AppSpacing.medium) {
                infoRowText(icon: "doc.text.magnifyingglass", title: "Order ID :", value: "#\(order.number)")
                infoRowText(icon: "shippingbox", title: "Order Status :", value: order.status.rawValue.capitalized)
                infoRowText(icon: "calendar", title: datePrefixText, value: Self.dateFormatter.string(from: order.createdAt))
            }
        }
    }

    private var orderItemsSection: some View {
        sectionContainer(title: "Order Items") {
            VStack(spacing: AppSpacing.medium) {
                ForEach(order.items) { item in
                    HStack(spacing: AppSpacing.medium) {
                        productImageView(url: item.product.imageURL)

                        VStack(alignment: .leading, spacing: 4) {
                            Text(item.product.name)
                                .appTextStyle(.bodyMedium, color: .appDark, weight: .medium)
                                .lineLimit(2)
                                .multilineTextAlignment(.leading)

                            HStack(alignment: .bottom) {
                                Text("EGP \(NSDecimalNumber(decimal: item.subtotal).doubleValue, specifier: "%.0f")")
                                    .appTextStyle(.bodyMedium, color: .appDark, weight: .bold)
                                
                                Text("EGP \(NSDecimalNumber(decimal: item.product.price).doubleValue, specifier: "%.0f") for each")
                                    .appTextStyle(.captionMedium, color: .gray)
                            }
                        }

                        Spacer()

                        Text("X\(item.quantity)")
                            .appTextStyle(.bodyMedium, color: .appDark, weight: .bold)
                    }
                    .padding(AppSpacing.medium)
                    .background(AppColors.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color(.systemGray5), lineWidth: 1)
                    )
                }
            }
        }
    }

    private var priceSummarySection: some View {
        sectionContainer(title: "Price Summary") {
            VStack(spacing: AppSpacing.medium) {
                summaryRow(title: "Subtotal", value: "EGP \(NSDecimalNumber(decimal: subtotal).doubleValue, default: "%.0f")")
                summaryRow(title: "Delivery fee", value: "EGP \(NSDecimalNumber(decimal: deliveryFee).doubleValue, default: "%.0f")")
                if discount > 0 {
                    summaryRow(title: "Discount", value: "-EGP \(NSDecimalNumber(decimal: discount).doubleValue, default: "%.0f")", isDiscount: true)
                }

                DashedLine()
                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [4]))
                    .foregroundStyle(Color(.systemGray4))
                    .frame(height: 1)
                    .padding(.vertical, 4)

                HStack {
                    Text("Total")
                        .appTextStyle(.bodyLarge, color: .appDark, weight: .bold)
                    Spacer()
                    Text("EGP \(NSDecimalNumber(decimal: order.total).doubleValue, default: "%.0f")")
                        .appTextStyle(.bodyLarge, color: .appDark, weight: .bold)
                }
            }
        }
    }

    private var deliveryAddressSection: some View {
        sectionContainer(title: "Delivery Address") {
            infoRow(icon: "mappin.circle.fill", iconSize: 22) {
                VStack(alignment: .leading, spacing: 4) {
                    if let firstAddress = Address.mockAddresses.first {
                        Text(firstAddress.title)
                            .appTextStyle(.bodyMedium, color: .appDark, weight: .bold)
                        Text("\(firstAddress.street), \(firstAddress.city)")
                            .appTextStyle(.bodySmall, color: .gray)
                    } else {
                        Text("Home")
                            .appTextStyle(.bodyMedium, color: .appDark, weight: .bold)
                        Text("Ras El-Bar, Egypt")
                            .appTextStyle(.bodySmall, color: .gray)
                    }
                }
            }
        }
    }

    private var paymentMethodSection: some View {
        sectionContainer(title: "Payment Method") {
            infoRow(icon: "banknote", iconSize: 20) {
                Text("Cash on Delivery")
                    .appTextStyle(.bodyMedium, color: .appDark, weight: .medium)
            }
        }
    }

    // MARK: - Bottom Action Button
    private var bottomActionButton: some View {
        VStack {
            Button {
                if order.status == .delivered || order.status == .cancelled {
                    // Reorder Action - Go to checkout or show message
                } else {
                    router.push(.orderTracking(id: order.id))
                }
            } label: {
                Text(order.status == .delivered || order.status == .cancelled ? "Reorder" : "Track Order")
                    .appTextStyle(.bodyLarge, color: AppColors.white, weight: .bold)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(AppColors.primary)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
            }
            .padding(.horizontal, AppSpacing.large)
            .padding(.top, AppSpacing.medium)
            .padding(.bottom, AppSpacing.large)
        }
        .background(AppColors.white)
        .overlay(
            VStack {
                Divider()
                Spacer()
            }
        )
    }

    // MARK: - Helpers
    @ViewBuilder
    private func productImageView(url: URL?) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(.systemGray5), lineWidth: 1)
                .background(AppColors.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))

            if let url = url {
                AsyncImage(url: url) { image in
                    image.resizable().scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .padding(4)
            } else {
                Image(systemName: "photo")
                    .foregroundColor(.gray)
            }
        }
        .frame(width: 60, height: 60)
    }
}

// MARK: - Dashed Line Shape
struct DashedLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        return path
    }
}

// MARK: - Previews

#Preview("Preparing (Track Order Button)") {
    NavigationStack {
        SingleOrderView(orderID: 1)
            .environment(AppRouter())
    }
}

#Preview("Delivered (Reorder Button)") {
    NavigationStack {
        SingleOrderView(orderID: 2)
            .environment(AppRouter())
    }
}
