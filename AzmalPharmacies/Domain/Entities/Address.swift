import Foundation

struct Address: Identifiable, Equatable {
    let id: Int
    var title: String
    var street: String
    var city: String
    var notes: String?
    var latitude: Double?
    var longitude: Double?
}
