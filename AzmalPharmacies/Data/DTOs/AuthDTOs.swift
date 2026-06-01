import Foundation

struct LoginRequestDTO: Encodable {
    let phone: String
    let password: String
}

struct AuthResponseDTO: Decodable {
    let token: String?
    let user: UserDTO
}

struct UserDTO: Decodable {
    let id: Int
    let name: String
    let phone: String
    let email: String?
}
