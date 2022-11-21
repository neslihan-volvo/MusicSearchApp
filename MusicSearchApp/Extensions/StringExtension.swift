import SwiftUI
extension String{
    
    mutating func createSearchString()-> String{
        let trimmed = self.trimmingCharacters(in: .whitespacesAndNewlines)
        let mapped = String(trimmed.map {
            $0 == " " ? "+" : $0
        })
        return mapped
    }
}
