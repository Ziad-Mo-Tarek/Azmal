import SwiftUI

struct SecondaryButton: View {
    let title: String
    var systemImage: String?
    var isDisabled = false
    var action: () -> Void

    var body: some View {
        AppButton(
            title: title,
            style: .secondary,
            systemImage: systemImage,
            isDisabled: isDisabled,
            action: action
        )
    }
}
