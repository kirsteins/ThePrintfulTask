import Foundation

@MainActor final class CategoryModel: ObservableObject {
    @Published private(set) var products: [Product] = []
    @Published private(set) var isLoading = false

    @Published var error: Error? {
        didSet {
            if error != nil && products.isEmpty {
                canRetry = true
            }
        }
    }
    @Published private(set) var canRetry = false

    func getProductsIfNeeded(category: Category) async {
        if !isLoading && products.isEmpty {
            await getProducts(category: category)
        }
    }

    func getProducts(category: Category) async {
        canRetry = false
        isLoading = true

        // It seems that offset abd limit parameters are not supported, so load
        // everything at once.
        let string = "https://api.printful.com/products?category_id=\(category.id)"
        let url = URL(string: string)!

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            let decoder = JSONDecoder()

            if (response as? HTTPURLResponse)?.statusCode == 200 {
                let categoryTopLevel = try decoder.decode(CategoryTopResult.self, from: data)
                products = categoryTopLevel.result
            } else {
                let responseErrorPayload = try decoder.decode(ResponseError.self, from: data)
                throw LoadingDataError.responseError(responseErrorPayload)
            }
        } catch {
            self.error = error
        }

        isLoading = false
    }
}
