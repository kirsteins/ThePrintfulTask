import SwiftUI

struct CategoryView: View {
    let category: Category
    @StateObject var model = CategoryModel()

    @ViewBuilder var overlay: some View {
        if model.isLoading && model.products.isEmpty {
            VStack {
                ProgressView()
                Text("Loading products")
                    .font(.headline)
                    .foregroundColor(.secondary)
            }
        } else if model.canRetry {
            Button("Retry") {
                Task {
                    await model.getProducts(category: category)
                }
            }
        }
    }

    var body: some View {
        List(model.products) { product in
            NavigationLink(value: product) {
                ProductRow(product: product)
            }
        }
        .navigationDestination(for: Product.self) { product in
            ProductView(product: product)
        }
        .navigationTitle(category.title)
        .overlay(overlay)
        .task {
            await model.getProductsIfNeeded(category: category)
        }
        .refreshable {
            await model.getProducts(category: category)
        }
        .errorAlert(error: $model.error)
    }
}
