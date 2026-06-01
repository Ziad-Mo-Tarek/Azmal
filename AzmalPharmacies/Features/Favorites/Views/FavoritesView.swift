import SwiftUI

struct FavoritesView: View {
    var body: some View {
        EmptyStateView(title: "No favorites yet", message: "Favorite medicines will appear here.", systemImage: "heart")
            .navigationTitle("Favorites")
    }
}
