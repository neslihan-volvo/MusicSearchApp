import XCTest
@testable import MusicSearchApp

final class ImageDownloaderTests: XCTestCase {

    var sut : ImageDownloader!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testImageDownloader_whenRequestFailed_throwsError() async throws{
        
        let searchKey = "imageURL"
        let mockClient = MockNetworkClient()
        mockClient.statusCode = 404
        sut = ImageDownloader(networkClient: mockClient)
        
        do{
            let image = try await sut.getImage(url:searchKey)
            XCTFail("expecting error")
        }catch{
            XCTAssertEqual(error as? ImageDownloaderError, ImageDownloaderError.networkResponseInvalid)
        }
    }
    
    func testImageDownloader_whenResponseDataInvalid_returnError() async throws{
        
        let stringURL = "imageURL"
        let mockClient = MockNetworkClient()
        sut = ImageDownloader(networkClient: mockClient)
        
        do{
            let image = try await sut.getImage(url: stringURL)
            XCTFail("Should return error")
        }catch{
            XCTAssertEqual(error as? ImageDownloaderError, ImageDownloaderError.imageInitializationFailed)
        }
        
    }
    func testImageDownloader_whenUrlInvalid_returnError() async throws{
        
        let stringURL = ""
        let mockClient = MockNetworkClient()
        mockClient.url = stringURL
        sut = ImageDownloader(networkClient: mockClient)
        do{
            
            let image = try await sut.getImage(url: stringURL)
            XCTFail("Should return error")
            
        }catch{
            XCTAssertEqual(error as? ImageDownloaderError?, ImageDownloaderError.urlInvalid)
        }
    }
    func testImageDownloader_whenRequestSuccesful_returnResponse() async throws {
        let mockClient = MockNetworkClient()
        mockClient.data = ImageDownloaderTests.imageMockData()
        sut = ImageDownloader(networkClient: mockClient)
        do{
            let image = try await sut.getImage(url: "imageURL" )
            XCTAssertNotNil(image)
            //XCTAssertIdentical(image, UIImage(named: "sampleImage"))
            //(image,[UIImage (named: "sampleImage")])
        }catch{
            
        }
    }
}

extension ImageDownloaderTests{
    static func imageMockData() -> Data {
        let bundle = Bundle(for: ImageDownloaderTests.self)
        let imageUrl = bundle.url(forResource: "sampleImage.jpg", withExtension: nil)
        return try! Data(contentsOf: imageUrl!)
    }
}
