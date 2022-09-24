import SwiftUI

struct ProductRow: View {
    let product: Product
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: product.image)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Color(.lightGray)
            }
            .frame(width: 48, height: 48)

            VStack(alignment: .leading) {
                Text(product.title)
                Text("id: \(product.id)")
                    .foregroundColor(.secondary)
            }

            Spacer()
        }
    }
}

