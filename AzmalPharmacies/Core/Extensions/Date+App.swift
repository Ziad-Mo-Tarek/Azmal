import Foundation

extension Date {
    var shortDisplayText: String {
        formatted(date: .abbreviated, time: .omitted)
    }
}
