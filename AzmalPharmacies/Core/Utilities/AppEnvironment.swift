import Foundation

enum AppEnvironment {
    case development
    case production

    static let current: AppEnvironment = .development

    var baseURL: URL {
        switch self {
        case .development:
            URL(string: "https://api.azmal-pharmacies.example")!
        case .production:
            URL(string: "https://api.azmal-pharmacies.example")!
        }
    }
}
