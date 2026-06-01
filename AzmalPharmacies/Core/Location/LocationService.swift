import CoreLocation

protocol LocationServicing {
    func requestCurrentLocation() async throws -> CLLocationCoordinate2D
}

final class LocationService: NSObject, LocationServicing {
    func requestCurrentLocation() async throws -> CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: 30.0444, longitude: 31.2357)
    }
}
