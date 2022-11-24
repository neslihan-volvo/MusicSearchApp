import XCTest
@testable import MusicSearchApp
class MockNetworkClient:NetworkClient {
    func load(request: URLRequest) async throws -> (Data, URLResponse) {
        let data = Data()
        let urlResponse = HTTPURLResponse.init()
        return (data, urlResponse)
    }
    
    
}
final class ContentViewModelTests: XCTestCase {

    func testContentViewModel_whenResponseIsEmpty_showWarning() {
        let mockClient = MockNetworkClient()
        var sut = ContentViewModel(networkClient: mockClient)
        
        //var key = "Mabel Matiz"
        //var sut.getMusicList(searchKey: key)
        
        //XCTAssertEqual(response.resultCount, 0)
        //XCTAssertEqual(<#T##expression1: Equatable##Equatable#>, <#T##expression2: Equatable##Equatable#>)
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
