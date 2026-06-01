import Foundation

enum OrderMapper {
    static func map(_ dto: OrderDTO) -> Order {
        Order(
            id: dto.id,
            number: dto.number,
            status: OrderStatus(rawValue: dto.status) ?? .pending,
            total: dto.total,
            createdAt: dto.createdAt ?? Date(),
            items: []
        )
    }
}
