import SwiftUI

struct ProfileView: View {
    @Environment(AppRouter.self) private var router

    var body: some View {
        List {
            Section {
                Label("Ziad Tarek", systemImage: "person.circle")
            }
            Section {
                Button("Edit Profile") { router.push(.editProfile) }
                Button("Addresses") { router.push(.addresses) }
                Button("Settings") { router.push(.settings) }
                Button("Help") { router.push(.help) }
            }
        }
        .navigationTitle("Profile")
    }
}
