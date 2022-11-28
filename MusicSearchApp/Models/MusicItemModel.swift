import Foundation

public struct MusicItemModel: Codable, Identifiable {
    
    public let id : Int
    public let wrapperType: WrapperType
    public let kind: String
    public let trackName: String
    public let artistName: String
    public let collectionName: String
    public let artworkUrl100: String
    public let artworkUrl60: String
    public let previewUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id = "trackId"
        case wrapperType
        case kind
        case trackName
        case artistName
        case collectionName
        case artworkUrl100
        case artworkUrl60
        case previewUrl
    }
}
public enum WrapperType: String, Equatable, Codable {
    case track
    case collection
    case artist
}

public enum MusicSearchError: Error {
    case requestFailed
    case networkResponseInvalid
    case jsonDecodeFailed
    
}


var item1 = MusicItemModel(
    id:123124,
    wrapperType: WrapperType.track,
    kind: "song",
    trackName: "Upside Down",
    artistName: "Jack Johnson",
    collectionName: "Sing-a-Longs and Lullabies for the Film Curious George",
    artworkUrl100: "http://a1.itunes.apple.com/r10/Music/3b/6a/33/mzi.qzdqwsel.100x100-75.jpg",
    artworkUrl60: "http://a1.itunes.apple.com/r10/Music/3b/6a/33/mzi.qzdqwsel.60x60-50.jpg",
    previewUrl: "http://a1099.itunes.apple.com/r10/Music/f9/54/43/mzi.gqvqlvcq.aac.p.m4p"
)
var item2 = MusicItemModel(
    id:123124,
    wrapperType: WrapperType.track,
    kind: "song",
    trackName: "Upside Down",
    artistName: "Jack Johnson",
    collectionName: "Sing-a-Longs and Lullabies for the Film Curious George",
    artworkUrl100: "http://a1.itunes.apple.com/r10/Music/3b/6a/33/mzi.qzdqwsel.100x100-75.jpg",
    artworkUrl60: "http://a1.itunes.apple.com/r10/Music/3b/6a/33/mzi.qzdqwsel.60x60-50.jpg",
    previewUrl: "http://a1099.itunes.apple.com/r10/Music/f9/54/43/mzi.gqvqlvcq.aac.p.m4p"
)
var musicListArray = [item1, item2]

