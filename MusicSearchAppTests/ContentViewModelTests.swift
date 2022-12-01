import XCTest
@testable import MusicSearchApp

final class ContentViewModelTests: XCTestCase {
    var sut : ContentViewModel!
    
    func testContentViewModel_whenRequestFailed_throwsError() async throws{
        let searchKey = "anything"
        let mockClient = MockNetworkClient()
        mockClient.statusCode = 404
        sut = ContentViewModel(networkClient: mockClient)
        
        do{
            try await sut.getMusicList(searchKey)
            XCTFail("expecting error")
        }catch{
            XCTAssertEqual(error as? MusicSearchError, MusicSearchError.networkResponseInvalid)
        }
    }
    
    func testContentViewModel_whenRequestSuccesful_returnResponse() async throws{
        
        let searchKey = "Mabel+Matiz"
        let mockClient = MockNetworkClient()
        sut = ContentViewModel(networkClient: mockClient)
        
        do{
            try await sut.getMusicList(searchKey)
            let musicItemResult = sut.musicResultList.first
            XCTAssertFalse(sut.showAlert)
            XCTAssertEqual(musicItemResult?.wrapperType,WrapperType.track)
            XCTAssertEqual(musicItemResult?.kind, "song")
            XCTAssertEqual(musicItemResult?.id, 965168795)
            XCTAssertEqual(musicItemResult?.artistName, "Mabel Matiz")
            XCTAssertEqual(musicItemResult?.collectionName, "Gök Nerede")
            XCTAssertEqual(musicItemResult?.trackName, "Gel")
            XCTAssertEqual(musicItemResult?.previewUrl, "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/ad/93/2a/ad932a2a-de9c-f550-4fb3-59e1aa81c292/mzaf_172871375788736175.plus.aac.p.m4a")
            XCTAssertEqual(musicItemResult?.artworkUrl60, "https://is1-ssl.mzstatic.com/image/thumb/Music5/v4/3a/8c/6d/3a8c6d89-924a-a6ba-db8f-9b5d274170a7/cover.jpg/60x60bb.jpg")
            XCTAssertEqual(musicItemResult?.artworkUrl100,"https://is1-ssl.mzstatic.com/image/thumb/Music5/v4/3a/8c/6d/3a8c6d89-924a-a6ba-db8f-9b5d274170a7/cover.jpg/100x100bb.jpg")
        }catch{
            XCTFail("Should be run without error")
        }
        
    }
    func testContentViewModel_whenJsonResponseInvalid_returnError() async throws{
        
        let searchKey = "Mabel+Matiz"
        let mockClient = MockNetworkClient()
        mockClient.data = MockNetworkClient.invalidMockData()
        sut = ContentViewModel(networkClient: mockClient)
        
        do{
            try await sut.getMusicList(searchKey)
            let musicItemResult = sut.musicResultList.first
            XCTAssertNil(musicItemResult)
        }catch{
            XCTAssertEqual(error as? MusicSearchError, MusicSearchError.jsonDecodeFailed)
        }
    }
    func testContentViewModel_whenSearchResultCountZero_setShowAlertTrue() async {
        let searchKey = "meaninglesSearchKey"
        let mockClient = MockNetworkClient()
        mockClient.data = MockNetworkClient.emptyMockData()
        sut = ContentViewModel(networkClient: mockClient)
        
        do{
            try await sut.getMusicList(searchKey)
            
            XCTAssertTrue(sut.showAlert)
            XCTAssertTrue(sut.musicResultList.count == 0)
        }catch{
            XCTAssertEqual(error as? MusicSearchError, MusicSearchError.jsonDecodeFailed)
        }
    }
    override func setUpWithError() throws {
        
        //let mockClient = MockNetworkClient()
        //sut = ContentViewModel(networkClient: mockClient)
    }
    override func tearDownWithError() throws {
        
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}
