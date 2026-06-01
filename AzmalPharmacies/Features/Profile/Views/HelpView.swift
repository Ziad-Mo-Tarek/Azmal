import SwiftUI

struct HelpView: View {
    var body: some View {
        List {
            Label("Contact support", systemImage: "phone")
            Label("FAQ", systemImage: "questionmark.circle")
        }
        .navigationTitle("Help")
    }
}
