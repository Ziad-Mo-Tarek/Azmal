import SwiftUI

struct UploadPrescriptionView: View {
    var body: some View {
        VStack(spacing: AppSpacing.large) {
            EmptyStateView(title: "Upload Prescription", message: "Add a prescription image and the pharmacy team will prepare the medicines.", systemImage: "doc.text.image")
            PrimaryButton(title: "Choose Image", systemImage: "photo") {}
        }
        .appScreenPadding()
        .background(AppColors.background)
        .navigationTitle("Prescription")
    }
}
