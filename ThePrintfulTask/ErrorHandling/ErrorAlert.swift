import SwiftUI

struct LocalizedAlertError: LocalizedError {
    let underlyingError: NSError
    var errorDescription: String? {
        underlyingError.localizedDescription
    }
    var recoverySuggestion: String? {
        underlyingError.localizedRecoverySuggestion
    }

    init?(error: Error?) {
        guard let nsError = error as? NSError else { return nil }
        underlyingError = nsError
    }
}

extension View {
    func errorAlert(error: Binding<Error?>, buttonTitle: String = "OK") -> some View {
        let localizedAlertError = LocalizedAlertError(error: error.wrappedValue)
        return alert(isPresented: .constant(localizedAlertError != nil), error: localizedAlertError) { _ in
            Button(buttonTitle) {
                error.wrappedValue = nil
            }
        } message: { error in
            Text(error.recoverySuggestion ?? "")
        }
    }
}
