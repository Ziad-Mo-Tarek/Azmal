import Foundation

enum ProductMapper {
    static func map(_ dto: ProductDTO) -> Product {
        Product(
            id: dto.id,
            name: dto.name,
            description: dto.description ?? "",
            price: dto.price,
            imageURL: dto.image.flatMap(URL.init(string:)),
            isAvailable: dto.available ?? true,
            categoryID: dto.categoryId
        )
    }

    static func map(_ dto: CategoryDTO) -> Category {
        Category(id: dto.id, name: dto.name, imageURL: dto.image.flatMap(URL.init(string:)))
    }
}
