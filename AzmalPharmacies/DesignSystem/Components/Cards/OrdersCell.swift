import SwiftUI

struct OrdersCell: View {
    let order: Order
    var onDetailsTapped: () -> Void
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy - h:mm a"
        return formatter
    }()
    
    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.medium) {
            
            // ── Top Row: Order ID & Status Badge ──
            HStack(alignment: .top) {
                HStack(spacing: 4) {
                    Text("Order ID :")
                        .appTextStyle(.bodyLarge, color: .appDark, weight: .bold)
                    Text("#\(order.number)")
                        .appTextStyle(.bodyLarge, color: AppColors.primary, weight: .bold)
                }
                .padding(.leading, AppSpacing.large)
                .padding(.top, AppSpacing.large)
                
                Spacer()
                
                statusBadge
            }
            
            // ── Date ──
            HStack(spacing: 4) {
                Text(datePrefixText)
                    .appTextStyle(.bodyMedium, color: .appDark, weight: .medium)
                Text(Self.dateFormatter.string(from: order.createdAt))
                    .appTextStyle(.bodyMedium, color: .gray)
            }
            .padding(.horizontal, AppSpacing.large)
            
            // ── Items ──
            HStack(spacing: AppSpacing.small) {
                Text("Items :")
                    .appTextStyle(.bodyMedium, color: .appDark, weight: .medium)
                
                HStack(spacing: 8) {
                    ForEach(order.items.prefix(3)) { item in
                        itemImageView(url: item.product.imageURL)
                    }
                }
                
                if order.items.count > 3 {
                    Text("+ \(order.items.count - 3) more")
                        .appTextStyle(.bodyMedium, color: .gray, weight: .medium)
                }
            }
            .padding(.horizontal, AppSpacing.large)
            
            // ── Total & Action Button ──
            HStack {
                HStack(spacing: 4) {
                    Text("Total :")
                        .appTextStyle(.bodyMedium, color: .appDark, weight: .bold)
                    Text("EGP \(NSDecimalNumber(decimal: order.total).doubleValue, specifier: "%.0f")")
                        .appTextStyle(.bodyMedium, color: .gray)
                }
                
                Spacer()
                
                Button(action: onDetailsTapped) {
                    Text("View Details")
                        .appTextStyle(.bodyMediumSmall, color: AppColors.primary, weight: .bold)
                        .padding(.horizontal, AppSpacing.large)
                        .padding(.vertical, 8)
                        .background(AppColors.white)
                        .overlay(
                            Capsule().stroke(AppColors.primary, lineWidth: 1)
                        )
                        .clipShape(Capsule())
                }
            }
            .padding(.horizontal, AppSpacing.large)
            .padding(.bottom, AppSpacing.large)
        }
        .background(AppColors.surface)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
    }
    
    // MARK: - Helpers
    
    private var datePrefixText: String {
        switch order.status {
        case .delivered: return "Delivered On :"
        case .cancelled: return "Cancelled On :"
        default: return "Ordered On :"
        }
    }
    
    private var statusColor: Color {
        switch order.status {
        case .delivered:
            return AppColors.success
        case .outForDelivery:
            return Color.blue
        case .cancelled:
            return AppColors.primary
        default:
            return Color.orange
        }
    }
    
    private var statusIcon: String {
        switch order.status {
        case .delivered:
            return "shippingbox"
        case .outForDelivery:
            return "box.truck"
        case .cancelled:
            return "xmark.circle"
        default:
            return "clock"
        }
    }
    
    private var statusText: String {
        switch order.status {
        case .outForDelivery:
            return "On The Way"
        default:
            return order.status.rawValue.capitalized
        }
    }
    
    @ViewBuilder
    private var statusBadge: some View {
        HStack(spacing: 6) {
            Image(systemName: statusIcon)
                .font(.system(size: 14))
            Text(statusText)
        }
        .appTextStyle(.bodySemiboldSmall, color: AppColors.white)
        .padding(.horizontal, AppSpacing.medium)
        .padding(.vertical, AppSpacing.medium)
        .background(statusColor)
        .clipShape(BottomLeftRoundedRectangle(radius: 16))
    }
    
    @ViewBuilder
    private func itemImageView(url: URL?) -> some View {
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
        .frame(width: 40, height: 40)
    }

}

// MARK: - Preview

#Preview("Pending") {
    OrdersCell(
        order: Order(
            id: 1,
            number: "1001",
            status: .pending,
            total: 450,
            createdAt: .now,
            items: []
        ),
        onDetailsTapped: {}
    )
    .padding()
}

#Preview("Delivered") {
    OrdersCell(
        order: Order(
            id: 2,
            number: "1002",
            status: .delivered,
            total: 1250,
            createdAt: .now,
            items: []
        ),
        onDetailsTapped: {}
    )
    .padding()
}

#Preview("Out For Delivery") {
    OrdersCell(
        order: Order(
            id: 3,
            number: "1003",
            status: .outForDelivery,
            total: 890,
            createdAt: .now,
            items: []
        ),
        onDetailsTapped: {}
    )
    .padding()
}

#Preview("Cancelled") {
    OrdersCell(
        order: Order(
            id: 4,
            number: "1004",
            status: .cancelled,
            total: 320,
            createdAt: .now,
            items: []
        ),
        onDetailsTapped: {}
    )
    .padding()
}

// MARK: - Custom Shape

struct BottomLeftRoundedRectangle: Shape {
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX + radius, y: rect.maxY))
        path.addArc(center: CGPoint(x: rect.minX + radius, y: rect.maxY - radius), radius: radius, startAngle: .degrees(90), endAngle: .degrees(180), clockwise: false)
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        return path
    }
}
