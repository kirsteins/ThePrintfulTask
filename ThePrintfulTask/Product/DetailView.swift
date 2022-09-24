import SwiftUI

struct DetailRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Text(value)
                .multilineTextAlignment(.trailing)
                .foregroundColor(.secondary)
        }
    }
}
