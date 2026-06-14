import SwiftUI

struct FilterView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var lowerPrice: Double = 200
    @State private var upperPrice: Double = 650
    
    let categories = ["medications", "Haircare", "Skincare", "Vitamins", "Mom & baby", "Body care"]
    @State private var selectedCategories: Set<String> = ["Haircare"]
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Filter")
                .appTextStyle(.headingSmall, color: .black)
                .padding(.top, AppSpacing.xLarge)
                .padding(.bottom, AppSpacing.large)
            
            Divider()
            
            ScrollView {
                VStack(alignment: .leading, spacing: AppSpacing.xLarge) {
                    // Price Range Section
                    VStack(alignment: .leading, spacing: AppSpacing.medium) {
                        Text("Price Range")
                            .appTextStyle(.bodyMedium, color: .black, weight: .semibold)
                        
                        RangeSlider(
                            lowerBound: $lowerPrice,
                            upperBound: $upperPrice,
                            range: 0...1000,
                            step: 10
                        )
                        .padding(.top, AppSpacing.small)
                        
                        HStack {
                            Text("EGP \(Int(lowerPrice))")
                                .appTextStyle(.bodySmall, color: .black, weight: .semibold)
                            Spacer()
                            Text("EGP \(Int(upperPrice))")
                                .appTextStyle(.bodySmall, color: .black, weight: .semibold)
                        }
                    }
                    
                    // Category Section
                    VStack(alignment: .leading, spacing: AppSpacing.medium) {
                        Text("Category")
                            .appTextStyle(.bodyMedium, color: .black, weight: .semibold)
                        
                        FlowLayout(spacing: AppSpacing.small) {
                            ForEach(categories, id: \.self) { category in
                                let isSelected = selectedCategories.contains(category)
                                
                                Button(action: {
                                    if isSelected {
                                        selectedCategories.remove(category)
                                    } else {
                                        selectedCategories.insert(category)
                                    }
                                }) {
                                    Text(category)
                                        .appTextStyle(
                                            .bodySmall,
                                            color: isSelected ? .white : .black,
                                            weight: .semibold
                                        )
                                        .padding(.horizontal, AppSpacing.large)
                                        .padding(.vertical, 8)
                                        .background(
                                            Capsule()
                                                .fill(isSelected ? AppColors.primary : AppColors.surface)
                                        )
                                        .overlay(
                                            Capsule()
                                                .strokeBorder(isSelected ? AppColors.primary : AppColors.border, lineWidth: 1)
                                        )
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                }
                .padding(AppSpacing.large)
            }
            
            Spacer(minLength: 0)
            
            // Bottom Buttons
            HStack(spacing: AppSpacing.large) {
                SecondaryButton(title: "Reset") {
                    lowerPrice = 0
                    upperPrice = 1000
                    selectedCategories.removeAll()
                }
                
                PrimaryButton(title: "Apply") {
                    dismiss()
                }
            }
            .padding(AppSpacing.large)
        }
        .background(AppColors.surface)
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
    }
}

#Preview {
    FilterView()
}
