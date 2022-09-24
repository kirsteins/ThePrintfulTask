import Foundation

struct CategoryTopResult: Codable {
    let code: Int
    let result: [Product]
}

struct Product: Codable, Identifiable, Hashable {
    let id: Int
    let mainCategoryId: Int
    let type: String
    let typeName: String
    let title: String
    let brand: String?
    let model: String
    let image: String
    let variantCount: Int
    let currency: String
    let resultDescription: String

    enum CodingKeys: String, CodingKey {
        case id
        case mainCategoryId = "main_category_id"
        case type
        case typeName = "type_name"
        case title, brand, model, image
        case variantCount = "variant_count"
        case currency
        case resultDescription = "description"
    }
}
