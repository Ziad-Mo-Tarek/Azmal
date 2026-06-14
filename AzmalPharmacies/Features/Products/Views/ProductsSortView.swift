import SwiftUI

struct ProductsSortView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedSortOption: SortOption = .nameAsc
    
    enum SortOption: String, CaseIterable {
        case nameAsc = "Item Name : A - Z"
        case nameDesc = "Item Name : Z - A"
        case priceAsc = "Price : Low To High"
        case priceDesc = "Price : High To Low"
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Sort By")
                .appTextStyle(.headingSmall, color: .black)
                .padding(.top, AppSpacing.xLarge)
                .padding(.bottom, AppSpacing.large)
            
            Divider()
            
            VStack(spacing: AppSpacing.large) {
                ForEach(SortOption.allCases, id: \.self) { option in
                    Button(action: {
                        selectedSortOption = option
                    }) {
                        HStack {
                            Text(option.rawValue)
                                .appTextStyle(.bodyMedium, color: .black)
                            
                            Spacer()
                            
                            ZStack {
                                Circle()
                                    .strokeBorder(selectedSortOption == option ? AppColors.primary : AppColors.border, lineWidth: 1)
                                    .frame(width: 24, height: 24)
                                
                                if selectedSortOption == option {
                                    Circle()
                                        .fill(AppColors.primary)
                                        .frame(width: 20, height: 20)
                                }
                            }
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, AppSpacing.large)
            .padding(.top, AppSpacing.xLarge)
            
            Spacer()
            
            HStack(spacing: AppSpacing.large) {
                SecondaryButton(title: "Reset") {
                    selectedSortOption = .nameAsc
                }
                
                PrimaryButton(title: "Apply") {
                    dismiss()
                }
            }
            .padding(AppSpacing.large)
        }
        .background(AppColors.surface)
        .presentationDetents([.fraction(0.55)])
        .presentationDragIndicator(.visible)
    }
}

#Preview {
    ProductsSortView()
}
