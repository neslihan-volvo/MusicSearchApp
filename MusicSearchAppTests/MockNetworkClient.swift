//
//  MockNetworkClient.swift
//  MusicSearchAppTests
//
//  Created by Neslihan Doğan Aydemir on 2022-11-29.
//

import Foundation
@testable import MusicSearchApp

class MockNetworkClient:NetworkClient {
    var statusCode = 200
    var url = "https://www.volvocars.com"
    var data = MockNetworkClient.mockData()
    
    func load(request: URLRequest) async throws -> (Data, URLResponse) {
        let urlResponse = HTTPURLResponse.mock(statusCode: statusCode, url: url)
        return (data, urlResponse)
    }
    
    
}
extension HTTPURLResponse {
    static func mock(statusCode: Int, url: String) -> HTTPURLResponse {
        HTTPURLResponse(url: URL(string: url)!,
                        statusCode: statusCode,
                        httpVersion: "1.1",
                        headerFields: nil)!
    }
}
class FalingMockNetworkClient : NetworkClient {
    func load(request: URLRequest) async throws -> (Data, URLResponse) {
        throw NSError()
    }
    
    
}
extension MockNetworkClient {
    static func mockData() -> Data {
        let data = """
                {
                    "resultCount":2,
                    "results": [
                        {
                            "wrapperType":"track",
                            "kind":"song",
                            "artistId":450552292,
                            "collectionId":965167828,
                            "trackId":965168795,
                            "artistName":"Mabel Matiz",
                            "collectionName":"Gök Nerede",
                            "trackName":"Gel",
                            "collectionCensoredName":"Gök Nerede",
                            "trackCensoredName":"Gel",
                            "artistViewUrl":"https://music.apple.com/us/artist/mabel-matiz/450552292?uo=4",
                            "collectionViewUrl":"https://music.apple.com/us/album/gel/965167828?i=965168795&uo=4",
                            "trackViewUrl":"https://music.apple.com/us/album/gel/965167828?i=965168795&uo=4",
                            "previewUrl":"https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/ad/93/2a/ad932a2a-de9c-f550-4fb3-59e1aa81c292/mzaf_172871375788736175.plus.aac.p.m4a",
                            "artworkUrl30":"https://is1-ssl.mzstatic.com/image/thumb/Music5/v4/3a/8c/6d/3a8c6d89-924a-a6ba-db8f-9b5d274170a7/cover.jpg/30x30bb.jpg",
                            "artworkUrl60":"https://is1-ssl.mzstatic.com/image/thumb/Music5/v4/3a/8c/6d/3a8c6d89-924a-a6ba-db8f-9b5d274170a7/cover.jpg/60x60bb.jpg",
                            "artworkUrl100":"https://is1-ssl.mzstatic.com/image/thumb/Music5/v4/3a/8c/6d/3a8c6d89-924a-a6ba-db8f-9b5d274170a7/cover.jpg/100x100bb.jpg",
                            "releaseDate":"2015-02-13T08:00:00Z",
                            "collectionExplicitness":"notExplicit",
                            "trackExplicitness":"notExplicit",
                            "discCount":1,
                            "discNumber":1,
                            "trackCount":14,
                            "trackNumber":2,
                            "trackTimeMillis":287265,
                            "country":"USA",
                            "currency":"USD",
                            "primaryGenreName":"Turkish Pop",
                            "isStreamable":true

                        },
                        {
                            "wrapperType":"track",
                            "kind":"song",
                            "artistId":450552292,
                            "collectionId":595975814,
                            "trackId":595975824,
                            "artistName":"Mabel Matiz",
                            "collectionName":"Yaşım Çocuk",
                            "trackName":"Aşk Yok Olmaktır",
                            "collectionCensoredName":"Yaşım Çocuk",
                            "trackCensoredName":"Aşk Yok Olmaktır",
                            "artistViewUrl":"https://music.apple.com/us/artist/mabel-matiz/450552292?uo=4",
                            "collectionViewUrl":"https://music.apple.com/us/album/a%C5%9Fk-yok-olmakt%C4%B1r/595975814?i=595975824&uo=4",
                            "trackViewUrl":"https://music.apple.com/us/album/a%C5%9Fk-yok-olmakt%C4%B1r/595975814?i=595975824&uo=4",
                            "previewUrl":"https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/61/44/42/6144425a-41f9-3f3f-606c-3c05d7251160/mzaf_6368459494028247135.plus.aac.p.m4a",
                            "artworkUrl30":"https://is4-ssl.mzstatic.com/image/thumb/Music/v4/dd/8d/cb/dd8dcba7-c2af-d363-5662-228b054ee423/cover.jpg/30x30bb.jpg",
                            "artworkUrl60":"https://is4-ssl.mzstatic.com/image/thumb/Music/v4/dd/8d/cb/dd8dcba7-c2af-d363-5662-228b054ee423/cover.jpg/60x60bb.jpg",
                            "artworkUrl100":"https://is4-ssl.mzstatic.com/image/thumb/Music/v4/dd/8d/cb/dd8dcba7-c2af-d363-5662-228b054ee423/cover.jpg/100x100bb.jpg",
                            "releaseDate":"2012-12-28T08:00:00Z",
                            "collectionExplicitness":"notExplicit",
                            "trackExplicitness":"notExplicit",
                            "discCount":1,
                            "discNumber":1,
                            "trackCount":12,
                            "trackNumber":5,
                            "trackTimeMillis":223530,
                            "country":"USA",
                            "currency":"USD",
                            "primaryGenreName":"Turkish Pop",
                            "isStreamable":true

                        }
                       ]
                }
        """
        return data.data(using: .utf8)!
    }
    static func invalidMockData() -> Data {
        let data = """
                {
                    "resultCount":1,
                    "results": [
                        {
                            "wrapperType":"track",
                            "kind":"song",
                            "artistName":"Mabel Matiz",
                            "collectionName":"Yaşım Çocuk",
                            "trackName":"Aşk Yok Olmaktır",
                            "artworkUrl60":"https://is4-ssl.mzstatic.com/image/thumb/Music/v4/dd/8d/cb/dd8dcba7-c2af-d363-5662-228b054ee423/cover.jpg/60x60bb.jpg",
                            "artworkUrl100":"https://is4-ssl.mzstatic.com/image/thumb/Music/v4/dd/8d/cb/dd8dcba7-c2af-d363-5662-228b054ee423/cover.jpg/100x100bb.jpg",
         
                        }
                       ]
                }
        """
        return data.data(using: .utf8)!
    }
    static func emptyMockData() -> Data {
        let data = """
                {
                    "resultCount":0,
                    "results": []
                }
        """
        return data.data(using: .utf8)!
    }
    static func mockResponseData() throws -> MusicSearchResponse{
        let data = mockData()
        return try JSONDecoder().decode(MusicSearchResponse.self, from: data)
    }
}
