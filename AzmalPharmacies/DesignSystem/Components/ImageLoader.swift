//
//  ImageLoader.swift
//  AIChatCourse
//
//  Created by Ziad Tarek on 12/04/2026.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageLoader: View {
    var urlString: String = AppConstants.randomeImage
    var contentMode: ContentMode = .fill
    var forceTransitionAnimation: Bool = false
    var body: some View {
        Rectangle()
            .opacity(0.001)
            .overlay {
                WebImage(url: URL(string: urlString))
                    .resizable()
                    .indicator(.activity)
                    .aspectRatio(contentMode: contentMode)
                    .allowsHitTesting(false)
            }
            .clipped()
            .ifSatisfiesCondition(forceTransitionAnimation) { content in
                content
                    .drawingGroup()
            }
    }
}

#Preview {
    ImageLoader( )
}
