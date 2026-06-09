//
//  DiscountShape.swift
//  AzmalPharmacies
//
//  Created by Ziad Tarek on 09/06/2026.
//

import SwiftUI

//struct DiscountShape: View {
//    var body: some View {
//        Path { path in
//            
//            
//        }
//    }
//}

#Preview {
//    TicketRibbonShape()
//        .frame(width: 95, height: 17)
    DiscountTag(text: "Buy 1 get 1 free")
}



struct TicketRibbonShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Start at top-left
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        
        // Top edge to the far right
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        
        path.addLine(to: CGPoint(x: rect.maxX * 0.7, y: rect.maxY * 0.7))
        
        // Bottom edge back to the left
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        
        // Close the shape back to the start
        path.closeSubpath()
        
        return path
    }
}



struct DiscountTag: View {
    var text: String
    var backgroundColor: Color = .appSecondary
    
    var body: some View {
        Text(text)
            .appTextStyle(.captionMedium, color: .black, weight: .medium)
            .padding(5)
            .background(
                TicketRibbonShape()
                    .fill(backgroundColor)
            )
    }
}
