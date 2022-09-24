import Foundation

struct CategoriesTopLevel: Codable {
    let code: Int
    let result: CategoryResult
}

struct CategoryResult: Codable {
    let categories: [Category]
}

struct Category: Codable, Hashable, Identifiable {
    let id: Int
    let parentId: Int
    let imageURL: String
    let title: String

    enum CodingKeys: String, CodingKey {
        case id
        case parentId = "parent_id"
        case imageURL = "image_url"
        case title
    }
}
