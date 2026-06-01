import Foundation

struct AuthRepository: AuthRepositoryProtocol {
    private let service: AuthAPIService
    private let tokenProvider: TokenProvider

    init(apiClient: APIClientProtocol, tokenProvider: TokenProvider) {
        self.service = AuthAPIService(apiClient: apiClient)
        self.tokenProvider = tokenProvider
    }

    func login(phone: String, password: String) async throws -> User {
        let response = try await service.login(phone: phone, password: password)
        tokenProvider.save(accessToken: response.token)
        return UserMapper.map(response.user)
    }

    func register(name: String, phone: String, password: String) async throws -> User {
        User(id: 0, name: name, phone: phone, email: nil)
    }

    func verifyOTP(phone: String, code: String) async throws {}

    func logout() async {
        tokenProvider.clear()
    }
}
