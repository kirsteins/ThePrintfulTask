import Foundation

struct ResponseError: Codable {
    let code: Int
    let result: String
    let error: ErrorPayload
}

struct ErrorPayload: Codable {
    let reason: String
    let message: String
}
