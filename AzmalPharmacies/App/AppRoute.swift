import SwiftUI

enum AppRoute: Hashable {
    case splash
    case onboarding
    case login
    case register
    case otpVerification(phone: String)
    case productDetails(id: Int)
    case productSearch
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

extension AppRoute {
    @ViewBuilder
    var destination: some View {
        switch self {
        case .splash:
            SplashView()
        case .onboarding:
            OnboardingView()
        case .login:
            LoginView()
        case .register:
            RegisterView()
        case .otpVerification(let phone):
            OTPVerificationView(phone: phone)
        case .productDetails(let id):
            ProductDetailsView(productID: id)
        case .productSearch:
            ProductsView()
        case .pharmacyDetails(let id):
            PharmacyDetailsView(pharmacyID: id)
        case .prescriptionUpload:
            UploadPrescriptionView()
        case .checkout:
            CheckoutView()
        case .orderDetails(let id):
            OrderDetailsView(orderID: id)
        case .orderTracking(let id):
            OrderTrackingView(orderID: id)
        case .editProfile:
            EditProfileView()
        case .addresses:
            AddressesView()
        case .settings:
            SettingsView()
        case .help:
            HelpView()
        }
    }
}

extension View {
    func withAppRouter() -> some View {
        self.navigationDestination(for: AppRoute.self) { route in
            route.destination
        }
    }
}
