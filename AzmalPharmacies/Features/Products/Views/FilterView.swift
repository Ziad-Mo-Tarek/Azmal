import SwiftUI

struct FilterView: View {
    var body: some View {
        List {
            Toggle("Available only", isOn: .constant(true))
            Toggle("Nearest pharmacy", isOn: .constant(false))
        }
        .navigationTitle("Filters")
    }
}
