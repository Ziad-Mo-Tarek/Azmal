//
//  CustomSearchBar.swift
//  AzmalPharmacies
//
//  Created by Ziad Tarek on 08/06/2026.
//


import SwiftUI

struct CustomSearchBar: View {
    @Binding var text: String
    var placeholder: LocalizedStringKey = "Search..."
    var borderColor: Color = .primaryApp
    var body: some View {
        HStack(spacing: 12) {
            // Search Icon
            Image(systemName: "magnifyingglass")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(Color(UIColor.systemGray2))
            TextField(placeholder, text: $text)
                .font(.system(size: 16))
                .foregroundColor(.primary)
                // Optional: Adds a clear button when text is entered
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .opacity(text.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            text = ""
                        }
                    , alignment: .trailing
                )
        }
        .padding(.vertical, 14)
        .padding(.horizontal, 16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .stroke(borderColor, lineWidth: 0.5)
                .background(Color(UIColor.systemBackground).cornerRadius(30)) // Ensures solid background for dark/light mode
        )
    }
}


#Preview {
    CustomSearchBar(text: .constant(""), placeholder: "Hello")
        .padding(.horizontal)
}
