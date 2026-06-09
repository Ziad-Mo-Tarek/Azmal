//
//  CustomCorner.swift
//  AzmalPharmacies
//
//  Created by Ziad Tarek on 09/06/2026.
//
import SwiftUI

struct CustomCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
