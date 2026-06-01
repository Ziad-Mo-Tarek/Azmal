import Foundation
import Observation

@Observable
final class DependencyContainer {
    static let live = DependencyContainer()

    let apiClient: APIClientProtocol
    let authSession: AuthSession
    let tokenProvider: TokenProvider

    let authRepository: AuthRepositoryProtocol
    let productRepository: ProductRepositoryProtocol
    let cartRepository: CartRepositoryProtocol
    let orderRepository: OrderRepositoryProtocol
    let profileRepository: ProfileRepositoryProtocol

    init(
        apiClient: APIClientProtocol = APIClient(),
        authSession: AuthSession = AuthSession(),
        tokenProvider: TokenProvider = KeychainTokenProvider()
    ) {
        self.apiClient = apiClient
        self.authSession = authSession
        self.tokenProvider = tokenProvider
        self.authRepository = AuthRepository(apiClient: apiClient, tokenProvider: tokenProvider)
        self.productRepository = ProductRepository(apiClient: apiClient)
        self.cartRepository = CartRepository(apiClient: apiClient, tokenProvider: tokenProvider)
        self.orderRepository = OrderRepository(apiClient: apiClient, tokenProvider: tokenProvider)
        self.profileRepository = ProfileRepository(apiClient: apiClient, tokenProvider: tokenProvider)
    }
}
