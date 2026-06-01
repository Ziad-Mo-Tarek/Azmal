import Foundation

struct Pharmacy: Identifiable, Equatable {
    let id: Int
    var name: String
    var address: String
    var phone: String?
    var distanceText: String?
}
