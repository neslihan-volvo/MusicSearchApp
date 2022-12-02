import XCTest
@testable import MusicSearchApp

final class ContentViewModelTests: XCTestCase {
    var sut : ContentViewModel!
    
    func testContentViewModel_whenRequestFailed_throwsError() async throws{
        let searchKey = "anything"
        let mockClient = MockNetworkClient()
        mockClient.statusCode = 404
        sut = ContentViewModel(networkClient: mockClient)
        
        await sut.loadResults(searchKey)
        
        XCTAssertEqual(sut.state, .error)
    }
    
    func testContentViewModel_whenRequestSuccesful_returnResponse() async throws{
        
        let searchKey = "Mabel+Matiz"
        let mockClient = MockNetworkClient()
        sut = ContentViewModel(networkClient: mockClient)
        await sut.loadResults(searchKey)
        
        switch sut.state {
        case .loaded(results: let loadedResults):
            let item = loadedResults.first
            XCTAssertEqual(item?.wrapperType, WrapperType.track)
            XCTAssertEqual(item?.kind, "song")
            XCTAssertEqual(item?.id, 965168795)
            XCTAssertEqual(item?.artistName, "Mabel Matiz")
            XCTAssertEqual(item?.collectionName, "Gök Nerede")
            XCTAssertEqual(item?.trackName, "Gel")
            XCTAssertEqual(item?.previewUrl, "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/ad/93/2a/ad932a2a-de9c-f550-4fb3-59e1aa81c292/mzaf_172871375788736175.plus.aac.p.m4a")
            XCTAssertEqual(item?.artworkUrl60, "https://is1-ssl.mzstatic.com/image/thumb/Music5/v4/3a/8c/6d/3a8c6d89-924a-a6ba-db8f-9b5d274170a7/cover.jpg/60x60bb.jpg")
            XCTAssertEqual(item?.artworkUrl100,"https://is1-ssl.mzstatic.com/image/thumb/Music5/v4/3a/8c/6d/3a8c6d89-924a-a6ba-db8f-9b5d274170a7/cover.jpg/100x100bb.jpg")
            
        case .error:
            XCTFail("There should be an empty data not an error")
        case .idle:
            XCTFail("There should be an empty data not an idle")
        case .loading:
            XCTFail("There should be an empty data not an loading")
        }
        
        
    }
    func testContentViewModel_whenJsonResponseInvalid_returnError() async throws{
        
        let searchKey = "Mabel+Matiz"
        let mockClient = MockNetworkClient()
        mockClient.data = MockNetworkClient.invalidMockData()
        sut = ContentViewModel(networkClient: mockClient)
        
        await sut.loadResults(searchKey)
        
        XCTAssertEqual(sut.state, .error)
        
    }
    func testContentViewModel_whenSearchResultCountZero_setShowAlertTrue() async {
        let searchKey = "meaninglesSearchKey"
        let mockClient = MockNetworkClient()
        mockClient.data = MockNetworkClient.emptyMockData()
        sut = ContentViewModel(networkClient: mockClient)
        
        await sut.loadResults(searchKey)
        
        switch sut.state {
        case .loaded(results: let loadedResults):
            XCTAssertEqual(loadedResults.count, 0)
            XCTAssertTrue(loadedResults.isEmpty)
            break
        case .error:
            XCTFail("There should be an empty data not an error")
        case .idle:
            XCTFail("There should be an empty data not an idle")
        case .loading:
            XCTFail("There should be an empty data not an loading")
        }
    }
}
