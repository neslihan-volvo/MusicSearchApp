//
//  ArtistModel.swift
//  MusicSearchApp
//
//  Created by Neslihan Doğan Aydemir on 2022-11-15.
//
import SwiftUI

public struct MusicListItem: Codable, Identifiable {
    
    public let id : Int
    public let wrapperType: WrapperType
    public let kind: String
    public let artistId: Int
    public let artistName: String
    public let collectionName: String
    public let trackName: String
    public let artistViewUrl: String
    public let collectionViewUrl: String
    public let previewUrl: String
    public let artworkUrl60: String
    public let artworkUrl100: String
    public let collectionPrice: Double
    public let trackPrice: Double
    public let currency: String
    
    enum CodingKeys: String, CodingKey {
        case id = "trackId"
        case wrapperType
        case kind
        case artistId
        case artistName
        case collectionName
        case trackName
        case artistViewUrl
        case collectionViewUrl
        case previewUrl
        case artworkUrl60
        case artworkUrl100
        case collectionPrice
        case trackPrice
        case currency
    }
}
public enum WrapperType: String, Equatable, Codable {
    case track
    case collection
    case artist
}

public enum MusicSearchError: Error {
    case requestFailed
    case jsonDecodeFailed
    
}


var item1 = MusicListItem(
    id:123124,
    wrapperType: WrapperType.track,
    kind: "song",
    artistId: 1234,
    artistName: "Jack Johnson",
    collectionName: "Sing-a-Longs and Lullabies for the Film Curious George",
    trackName: "Upside Down",
    artistViewUrl: "https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewArtist?id=909253",
    collectionViewUrl: "https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewAlbum?i=120954025&id=120954021&s=143441",
    previewUrl: "http://a1099.itunes.apple.com/r10/Music/f9/54/43/mzi.gqvqlvcq.aac.p.m4p",
    artworkUrl60: "http://a1.itunes.apple.com/r10/Music/3b/6a/33/mzi.qzdqwsel.60x60-50.jpg",
    artworkUrl100: "http://a1.itunes.apple.com/r10/Music/3b/6a/33/mzi.qzdqwsel.100x100-75.jpg",
    collectionPrice: 10.99,
    trackPrice: 0.99,
    currency: "USD"
)
var item2 = MusicListItem(
    id:1234,
    wrapperType: WrapperType.track,
    kind: "song",
    artistId: 1234,
    artistName: "Jack Johnson",
    collectionName: "Sing-a-Longs and Lullabies for the Film Curious George",
    trackName: "Upside Down",
    artistViewUrl: "https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewArtist?id=909253",
    collectionViewUrl: "https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewAlbum?i=120954025&id=120954021&s=143441",
    previewUrl: "http://a1099.itunes.apple.com/r10/Music/f9/54/43/mzi.gqvqlvcq.aac.p.m4p",
    artworkUrl60: "http://a1.itunes.apple.com/r10/Music/3b/6a/33/mzi.qzdqwsel.60x60-50.jpg",
    artworkUrl100: "http://a1.itunes.apple.com/r10/Music/3b/6a/33/mzi.qzdqwsel.100x100-75.jpg",
    collectionPrice: 10.99,
    trackPrice: 0.99,
    currency: "USD"
)
var musicListArray = [item1, item2]

