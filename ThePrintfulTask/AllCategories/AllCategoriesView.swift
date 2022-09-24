import SwiftUI

struct AllCategoriesView: View {
    @StateObject var model = AllCategoriesModel()
    @State private var path = NavigationPath()

    @ViewBuilder var overlay: some View {
        if model.isLoading && model.categories.isEmpty {
            VStack {
                ProgressView()
                Text("Loading categories")
                    .font(.headline)
                    .foregroundColor(.secondary)
            }
        } else if model.canRetry {
            Button("Retry") {
                Task {
                    await model.getCategories()
                }
            }
        }
    }

    @ViewBuilder func image(forNode node: CategoryTreeNode) -> some View {
        if node.parent == nil {
            AsyncImage(url: URL(string: node.value.imageURL)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Color(.lightGray)
            }
            .frame(width: 60, height: 60)
        }
    }

    var body: some View {
        NavigationStack(path: $path) {
            List(model.categories, id: \.value, children: \.children) { categoryNode in
                Button(action: {
                    path.append(categoryNode.value)
                }) {
                    HStack {
                        image(forNode: categoryNode)
                        Text(categoryNode.value.title)
                            .font(categoryNode.parent == nil ? .headline : .subheadline)
                    }
                }
            }
            .listStyle(.sidebar)
            .navigationDestination(for: Category.self) { category in
                CategoryView(category: category)
            }
            .navigationTitle("Categories")
            .overlay(overlay)
            .task {
                await model.getCategoriesIfNeeded()
            }
            .refreshable {
                await model.getCategories()
            }
            .errorAlert(error: $model.error)
        }
    }
}
