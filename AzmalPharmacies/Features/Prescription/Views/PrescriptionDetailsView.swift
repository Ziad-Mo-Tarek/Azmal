import SwiftUI

struct PrescriptionDetailsView: View {
    let prescription: Prescription

    var body: some View {
        VStack(spacing: AppSpacing.large) {
            BadgeView(text: prescription.status.rawValue.capitalized)
            Text(prescription.createdAt.shortDisplayText)
        }
        .navigationTitle("Prescription")
    }
}
