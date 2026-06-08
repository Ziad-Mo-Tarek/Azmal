//
//  HomeBanner.swift
//  AzmalPharmacies
//
//  Created by Ziad Tarek on 08/06/2026.
//
import SwiftUI

struct HomeBanner: View {
    let slides: [HomeBannerSlide]
    @Binding var index: Int

    /// Seconds between automatic page advances.
    private let autoAdvanceInterval: Duration = .seconds(4)

    var body: some View {
        VStack(spacing: 8) {
            TabView(selection: $index) {
                ForEach(Array(slides.enumerated()), id: \.element.id) { offset, slide in
                    slideView(slide)
                        .tag(offset)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 156)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

            pageIndicator
        }
        .frame(maxWidth: .infinity)
        // Auto-advance loop; cancelled automatically when the view disappears.
        // Manual swipes update `index` directly via the TabView selection binding.
        .task {
            while !Task.isCancelled {
                try? await Task.sleep(for: autoAdvanceInterval)
                if Task.isCancelled { return }
                advance()
            }
        }
    }

    private func slideView(_ slide: HomeBannerSlide) -> some View {
        ZStack(alignment: .topLeading) {
            ImageLoader(urlString: slide.imageName)
        }
        
        .frame(height: 156)
        .accessibilityElement()
        .accessibilityLabel("Featured \(slide.caption) property banner")
    }

    private var pageIndicator: some View {
        HStack(spacing: 4) {
            ForEach(slides.indices, id: \.self) { slideIndex in
                if slideIndex == self.index {
                    Capsule(style: .continuous)
                        .fill(AppColors.primary) 
                        .frame(width: 15, height: 5)
                } else {
                    Circle()
                        .fill(AppColors.border)
                        .frame(width: 5, height: 5)
                }
            }
        }
        .animation(.easeInOut, value: index)
        .accessibilityLabel("Banner \(index + 1) of \(slides.count)")
    }

    private func advance() {
        guard !slides.isEmpty else { return }
        withAnimation(.easeInOut) {
            index = (index + 1) % slides.count
        }
    }
}

