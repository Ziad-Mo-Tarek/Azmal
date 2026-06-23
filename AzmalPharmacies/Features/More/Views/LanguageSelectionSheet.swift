//
//  LanguageSelectionSheet.swift
//  AzmalPharmacies
//
//  Created by Ziad Tarek on 23/06/2026.
//

import SwiftUI

// MARK: - Language Selection Sheet

struct LanguageSelectionSheet: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedLanguage: String = "English"

    var body: some View {
        VStack(spacing: AppSpacing.large) {
            // Header
            VStack(spacing: AppSpacing.medium) {
                Image(.languageIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundStyle(AppColors.primary)
                
                Text("Select App Language")
                    .appTextStyle(.headingSmall, color: .appDark, weight: .bold)
            }
            .padding(.top, AppSpacing.xLarge)

            // Options
            VStack(spacing: AppSpacing.medium) {
                languageOptionButton(title: "English")
                languageOptionButton(title: "العربية")
            }

            Spacer()

            // Buttons
            HStack(spacing: AppSpacing.medium) {
                AppButton(title: "Cancel", style: .secondary) {
                    dismiss()
                }
                
                AppButton(title: "Save", style: .primary) {
                    // Save logic
                    dismiss()
                }
            }
            .padding(.bottom, AppSpacing.large)
        }
        .padding(.horizontal, AppSpacing.large)
        .presentationDetents([.height(380)])
        .presentationDragIndicator(.visible)
    }

    @ViewBuilder
    private func languageOptionButton(title: String) -> some View {
        let isSelected = selectedLanguage == title
        Button {
            selectedLanguage = title
        } label: {
            HStack {
                Text(title)
                    .appTextStyle(.bodyLarge, color: .appDark, weight: .bold)
                
                Spacer()
                
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(AppColors.primary)
                        .font(.system(size: 26))
                }
            }
            .padding(.horizontal, AppSpacing.large)
            .frame(height: 60)
            .background(AppColors.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? AppColors.primary : Color(.systemGray5), lineWidth: isSelected ? 2 : 1)
            )
            .shadow(color: Color.black.opacity(isSelected ? 0 : 0.05), radius: 5, x: 0, y: 2)
        }
        .buttonStyle(.plain)
    }
}
