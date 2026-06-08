//
//  View+EXT.swift
//  AIChatCourse
//
//  Created by Ziad Tarek on 11/04/2026.
//

import SwiftUI


extension View {
    func callToActionButton() -> some View {
        self
            .font(.headline)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(.primaryApp)
            .cornerRadius(16)
    }
    
    func tapableBackgrounf() -> some View {
        self
            .background(Color.black.opacity(0.0001))
    }
    
    func removeListRowFormatting() -> some View {
        self
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowBackground(Color.clear)
    }
    
    func addingBackgroundGradientForText() -> some View {
        background(
            LinearGradient(colors: [
                Color.black.opacity(0),
                Color.black.opacity(0.3),
                Color.black.opacity(0.5)
            ], startPoint: .top, endPoint: .bottom)
        )
    }
    
    func badgeButton() -> some View {
        self
            .font(.caption)
            .foregroundStyle(.white)
            .bold()
            .padding(.horizontal, 8)
            .padding(.vertical, 6)
            .background(Color.blue)
            .cornerRadius(6)
    }
    
    @ViewBuilder
    func ifSatisfiesCondition(_ condition: Bool, transform: (Self) -> some View) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
}
