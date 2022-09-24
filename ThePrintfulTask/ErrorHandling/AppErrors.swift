import Foundation

enum LoadingDataError: LocalizedError {
    case responseError(ResponseError)

    var errorDescription: String? {
        switch self {
        case .responseError(let payload):
            return payload.error.reason
        }
    }

    var recoverySuggestion: String? {
        switch self {
        case .responseError(let payload):
            return payload.error.message
        }
    }
}

extension Error {
    var isUserCancelledError: Bool {
        (self as NSError).domain == NSURLErrorDomain && (self as NSError).code == NSURLErrorCancelled
    }
}
