//
//  ArtistModel.swift
//  MusicSearchApp
//
//  Created by Neslihan Doğan Aydemir on 2022-11-15.
//
import SwiftUI

public struct MusicListItem: Identifiable {
    public let id = UUID()
    public let wrapperType: WrapperType
    public let kind: String
    public let artistId: Int64
    public let trackId: Int64
    public let artistName: String
    public let collectionName: String
    public let trackName: String
    public let artisViewUrl: String
    public let collectionViewUrl: String
    public let previewUrl: String
    public let artworkUrl60: String
    public let artworkUrl100: String
    public let collectionPrice: Double
    public let trackPrice: Double
    public let currency: String
}

public enum WrapperType: Equatable {
    case track
    case collection
    case artist
}
var item1 = MusicListItem(
    wrapperType: WrapperType.track,
    kind: "song",
    artistId: 1234,
    trackId: 1234,
    artistName: "Jack Johnson",
    collectionName: "Sing-a-Longs and Lullabies for the Film Curious George",
    trackName: "Upside Down",
    artisViewUrl: "https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewArtist?id=909253",
    collectionViewUrl: "https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewAlbum?i=120954025&id=120954021&s=143441",
    previewUrl: "http://a1099.itunes.apple.com/r10/Music/f9/54/43/mzi.gqvqlvcq.aac.p.m4p",
    artworkUrl60: "http://a1.itunes.apple.com/r10/Music/3b/6a/33/mzi.qzdqwsel.60x60-50.jpg",
    artworkUrl100: "http://a1.itunes.apple.com/r10/Music/3b/6a/33/mzi.qzdqwsel.100x100-75.jpg",
    collectionPrice: 10.99,
    trackPrice: 0.99,
    currency: "USD"
)
var item2 = MusicListItem(
    wrapperType: WrapperType.track,
    kind: "song",
    artistId: 1234,
    trackId: 1234,
    artistName: "Jack Johnson",
    collectionName: "Sing-a-Longs and Lullabies for the Film Curious George",
    trackName: "Upside Down",
    artisViewUrl: "https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewArtist?id=909253",
    collectionViewUrl: "https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewAlbum?i=120954025&id=120954021&s=143441",
    previewUrl: "http://a1099.itunes.apple.com/r10/Music/f9/54/43/mzi.gqvqlvcq.aac.p.m4p",
    artworkUrl60: "http://a1.itunes.apple.com/r10/Music/3b/6a/33/mzi.qzdqwsel.60x60-50.jpg",
    artworkUrl100: "http://a1.itunes.apple.com/r10/Music/3b/6a/33/mzi.qzdqwsel.100x100-75.jpg",
    collectionPrice: 10.99,
    trackPrice: 0.99,
    currency: "USD"
)
var musicListArray = [item1, item2]

