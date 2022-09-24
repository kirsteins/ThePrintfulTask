import SwiftUI

struct ProductView: View {
    let product: Product

    var header: some View {
        VStack {
            AsyncImage(url: URL(string: product.image)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Color(.lightGray)
            }
            .frame(height: 300)
            Text(product.typeName)
                .foregroundColor(.secondary)
        }
    }

    var body: some View {
        List {
            Section {
                DetailRow(label: "Model", value: product.model)
                DetailRow(label: "Currency", value: product.currency)
                DetailRow(label: "Type", value: product.type)
                DetailRow(label: "Type name", value: product.typeName)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Description")
                    Text(product.resultDescription)
                        .foregroundColor(.secondary)
                }
            } header: {
                header
            }
        }
        .navigationTitle(product.title)
    }
}
