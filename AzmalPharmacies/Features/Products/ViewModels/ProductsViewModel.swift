import Foundation
import Observation

@Observable
final class ProductsViewModel {
    var searchText: String = ""
    var recentSearches: [String] = []
    var products: [Product] = []
    
    // Derived state, true if the user has submitted a search
    var isShowingResults: Bool = false
    
    init() {
        // Mock recent searches for demonstration
        self.recentSearches = [
            "Cerave daily Moisturizing lotion for normal to dr...",
            "Garnier",
            "Panadol Extra"
        ]
        
        self.products = Product.mockProducts
    }
    
    func performSearch() {
        guard !searchText.trimmingCharacters(in: .whitespaces).isEmpty else {
            isShowingResults = false
            return
        }
        
        // Add to recent searches if not already there
        if !recentSearches.contains(searchText) {
            recentSearches.insert(searchText, at: 0)
        }
        
        // Truncate to a reasonable limit, say 10
        if recentSearches.count > 10 {
            recentSearches.removeLast()
        }
        
        isShowingResults = true
    }
    
    func clearRecentSearches() {
        recentSearches.removeAll()
    }
    
    func removeRecentSearch(_ search: String) {
        recentSearches.removeAll { $0 == search }
    }
    
    func selectRecentSearch(_ search: String) {
        searchText = search
        performSearch()
    }
    
    func cancelSearch() {
        searchText = ""
        isShowingResults = false
    }
}
