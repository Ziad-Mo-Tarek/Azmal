import Foundation

extension Product {
    static let mockProducts: [Product] = [
        Product(id: 1, name: "Vitamin C", description: "Immune support tablets", price: 95, imageURL: nil, isAvailable: true, categoryID: 1),
        Product(id: 2, name: "Pain Relief", description: "Fast acting capsules", price: 62.5, imageURL: nil, isAvailable: true, categoryID: 2),
        Product(id: 3, name: "Cough Syrup", description: "Soothing syrup", price: 48, imageURL: nil, isAvailable: true, categoryID: 3),
        Product(id: 4, name: "First Aid Kit", description: "Home essentials", price: 210, imageURL: nil, isAvailable: true, categoryID: 4)
    ]
}

extension Category {
    static let mockCategories: [Category] = [
        Category(id: 1, name: "Vitamins", imageURL: nil),
        Category(id: 2, name: "Pain Relief", imageURL: nil),
        Category(id: 3, name: "Cold & Flu", imageURL: nil),
        Category(id: 4, name: "First Aid", imageURL: nil)
    ]
}

extension Pharmacy {
    static let mockPharmacies: [Pharmacy] = [
        Pharmacy(id: 1, name: "Azmal Pharmacy Nasr City", address: "Makram Ebeid, Cairo", phone: nil, distanceText: "1.2 km"),
        Pharmacy(id: 2, name: "Azmal Pharmacy Maadi", address: "Road 9, Cairo", phone: nil, distanceText: "3.4 km")
    ]
}

extension Address {
    static let mockAddresses: [Address] = [
        Address(id: 1, title: "Home", street: "12 Abbas El Akkad", city: "Cairo", notes: nil, latitude: nil, longitude: nil),
        Address(id: 2, title: "Work", street: "90th Street", city: "New Cairo", notes: nil, latitude: nil, longitude: nil)
    ]
}

extension Order {
    static let mockOrders: [Order] = [
        Order(id: 1, number: "#AZ-1001", status: .preparing, total: 140, createdAt: Date(), items: []),
        Order(id: 2, number: "#AZ-1000", status: .delivered, total: 260, createdAt: Date(), items: [])
    ]
}
