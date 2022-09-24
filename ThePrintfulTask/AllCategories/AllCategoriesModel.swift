import Foundation

@MainActor final class AllCategoriesModel: ObservableObject {
    @Published private(set) var categories: [CategoryTreeNode] = []
    @Published private(set) var isLoading = false

    @Published var error: Error? {
        didSet {
            if error != nil && categories.isEmpty {
                canRetry = true
            }
        }
    }
    @Published private(set) var canRetry = false

    func getCategoriesIfNeeded() async {
        if !isLoading && categories.isEmpty {
            await getCategories()
        }
    }

    func getCategories() async {
        canRetry = false
        isLoading = true

        let string = "https://api.printful.com/categories"
        let url = URL(string: string)!

        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()

            if (response as? HTTPURLResponse)?.statusCode == 200 {
                let categoriesTopLevel = try decoder.decode(CategoriesTopLevel.self, from: data)
                let categories = categoriesTopLevel.result.categories
                self.categories = makeTree(fromCategories: categories)
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
