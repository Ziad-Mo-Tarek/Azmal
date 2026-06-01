import Foundation

enum UserMapper {
    static func map(_ dto: UserDTO) -> User {
        User(id: dto.id, name: dto.name, phone: dto.phone, email: dto.email)
    }
}
