import Foundation

struct ProfileRepository: ProfileRepositoryProtocol {
    let apiClient: APIClientProtocol
    let tokenProvider: TokenProvider

    func profile() async throws -> User {
        User(id: 0, name: "Guest", phone: "", email: nil)
    }

    func addresses() async throws -> [Address] {
        []
    }

    func updateProfile(name: String, email: String?) async throws -> User {
        User(id: 0, name: name, phone: "", email: email)
    }
}
