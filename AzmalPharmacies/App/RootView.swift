import SwiftUI

struct RootView: View {
    @State private var appState = AppState()
    @State private var router = AppRouter()
    @State private var dependencies = DependencyContainer.live

    var body: some View {
        NavigationStack(path: $router.path) {
            MainTabView()
                .navigationDestination(for: AppRoute.self, destination: destination)
        }
        .environment(appState)
        .environment(router)
        .environment(dependencies)
    }

    @ViewBuilder
    private func destination(for route: AppRoute) -> some View {
        switch route {
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

#Preview {
    RootView()
}
