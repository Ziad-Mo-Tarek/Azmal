import SwiftUI

struct SettingsView: View {
    var body: some View {
        List {
            Toggle("Notifications", isOn: .constant(true))
            Toggle("Arabic", isOn: .constant(false))
        }
        .navigationTitle("Settings")
    }
}
