import Foundation

protocol AuthRepositoryProtocol {
    func login(phone: String, password: String) async throws -> User
    func register(name: String, phone: String, password: String) async throws -> User
    func verifyOTP(phone: String, code: String) async throws
    func logout() async
}
