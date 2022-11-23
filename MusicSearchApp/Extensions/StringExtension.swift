import Foundation

extension String {
    func makeSearchString() -> String {
        let trimmed = trimmingCharacters(in: .whitespacesAndNewlines)
        let mapped = String(trimmed.map {
            $0 == " " ? "+" : $0
        })
        return mapped
    }
}
