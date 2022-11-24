import Foundation
protocol NetworkClient: AnyObject {
    func load(request: URLRequest) async throws -> (Data, URLResponse)
    
}
class DefaultNetworkClient:NetworkClient {
    func load(request: URLRequest) async throws -> (Data, URLResponse) {
        let session = URLSession.shared
        return try await session.data(for: request)
    }
    
    
}

class ContentViewModel: ObservableObject {
    @Published var musicResultList: [MusicListItem] = []
    @Published var showAlert = false
    let networkClient : NetworkClient
    
    init(networkClient: NetworkClient = DefaultNetworkClient()) {
        self.networkClient = networkClient
    }
    func getMusicList(searchKey: String) async throws -> MusicSearchResponse {
        let urlPath = "https://itunes.apple.com/search?term=\(searchKey)&media=music"

        let request = URLRequest(url: URL(string:urlPath)!)
        let (data, response) = try await networkClient.load(request: request )
        guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode)
        else {
            throw MusicSearchError.requestFailed
        }
        
        do {
            let musicSearchResponse = try  JSONDecoder().decode(MusicSearchResponse.self, from: data)
            return musicSearchResponse
            
        } catch {
            throw error
        }
    }
    
    func getMusicList(_ keyword: String) async {
        let searchString = keyword.makeSearchString()
        
        do {
            let result = try await getMusicList(searchKey: searchString)
            await MainActor.run {
                musicResultList = result.results
                showAlert = result.resultCount == 0 ? true : false
            }
        } catch {
            print(error)
        }
    }
    
}
