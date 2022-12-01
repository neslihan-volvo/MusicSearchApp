import Foundation

public struct MusicSearchRequest {
    public var urlPath : String
    
    public init(_ key: String) {
        let searchKey = key.makeSearchString()
        self.urlPath = "https://itunes.apple.com/search?term=\(searchKey)&media=music"
    }
}
