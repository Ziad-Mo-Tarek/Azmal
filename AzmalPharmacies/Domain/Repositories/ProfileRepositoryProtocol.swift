import Foundation

protocol ProfileRepositoryProtocol {
    func profile() async throws -> User
    func addresses() async throws -> [Address]
    func updateProfile(name: String, email: String?) async throws -> User
}
