import Foundation

struct User: Identifiable, Equatable {
    let id: Int
    var name: String
    var phone: String
    var email: String?
}
