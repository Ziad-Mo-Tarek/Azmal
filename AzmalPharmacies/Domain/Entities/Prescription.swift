import Foundation

struct Prescription: Identifiable, Equatable {
    let id: Int
    var imageURL: URL?
    var status: PrescriptionStatus
    var createdAt: Date
}

enum PrescriptionStatus: String, CaseIterable {
    case uploaded
    case reviewing
    case priced
    case rejected
}
