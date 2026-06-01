import Foundation

enum AppRoute: Hashable {
    case onboarding
    case login
    case register
    case otpVerification(phone: String)
    case productDetails(id: Int)
    case pharmacyDetails(id: Int)
    case prescriptionUpload
    case checkout
    case orderDetails(id: Int)
    case orderTracking(id: Int)
    case editProfile
    case addresses
    case settings
    case help
}
