import SwiftUI

struct RangeSlider: View {
    @Binding var lowerBound: Double
    @Binding var upperBound: Double
    let range: ClosedRange<Double>
    let step: Double
    
    var body: some View {
        GeometryReader { geometry in
            let sliderWidth = geometry.size.width
            let thumbSize: CGFloat = 20
            
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(AppColors.border)
                    .frame(height: 4)
                    .cornerRadius(2)
                
                let startX = max(0, min(CGFloat((lowerBound - range.lowerBound) / (range.upperBound - range.lowerBound)) * sliderWidth, sliderWidth))
                let endX = max(0, min(CGFloat((upperBound - range.lowerBound) / (range.upperBound - range.lowerBound)) * sliderWidth, sliderWidth))
                
                Rectangle()
                    .fill(AppColors.primary)
                    .frame(width: max(0, endX - startX), height: 4)
                    .offset(x: startX)
                
                // Lower Thumb
                Circle()
                    .fill(Color(hex: "#FFC107") ?? .yellow) // Standard app yellow if it exists, otherwise fallback
                    .frame(width: thumbSize, height: thumbSize)
                    .shadow(radius: 2)
                    .offset(x: startX - thumbSize / 2)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let percentage = Double(value.location.x / sliderWidth)
                                let newValue = range.lowerBound + percentage * (range.upperBound - range.lowerBound)
                                lowerBound = min(max(newValue, range.lowerBound), upperBound - step)
                                lowerBound = round(lowerBound / step) * step
                            }
                    )
                
                // Upper Thumb
                Circle()
                    .fill(Color(hex: "#FFC107") ?? .yellow)
                    .frame(width: thumbSize, height: thumbSize)
                    .shadow(radius: 2)
                    .offset(x: endX - thumbSize / 2)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let percentage = Double(value.location.x / sliderWidth)
                                let newValue = range.lowerBound + percentage * (range.upperBound - range.lowerBound)
                                upperBound = max(min(newValue, range.upperBound), lowerBound + step)
                                upperBound = round(upperBound / step) * step
                            }
                    )
            }
            .frame(height: thumbSize)
        }
        .frame(height: 20)
    }
}

// Helper for hex color just in case
extension Color {
    init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0

        let length = hexSanitized.count

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }

        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0

        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0

        } else {
            return nil
        }

        self.init(red: r, green: g, blue: b, opacity: a)
    }
}
