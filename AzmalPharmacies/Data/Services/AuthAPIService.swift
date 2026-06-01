import Foundation

struct AuthAPIService {
    let apiClient: APIClientProtocol

    func login(phone: String, password: String) async throws -> AuthResponseDTO {
        let body = try JSONEncoder().encode(LoginRequestDTO(phone: phone, password: password))
        return try await apiClient.send(
            Endpoint(path: "auth/login", method: .post, body: body),
            responseType: AuthResponseDTO.self
        )
    }
}
