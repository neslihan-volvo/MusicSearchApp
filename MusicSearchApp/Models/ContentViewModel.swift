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
    @Published var musicResultList: [MusicItemModel] = []
    @Published var showAlert = false
    
    let networkClient : NetworkClient
    
    init(networkClient: NetworkClient = DefaultNetworkClient()) {
        self.networkClient = networkClient
    }
    
    func getMusicList(_ searchKey: String) async throws {

        let searchString = searchKey.makeSearchString()
        let urlPath = "https://itunes.apple.com/search?term=\(searchString)&media=music"
        
        // should I move follwing 5 lines to defoult network client with new func name?
        guard let searchURL = URL(string: urlPath)
        else {
            throw MusicSearchError.urlInvalid
        }
        let request = URLRequest(url: searchURL)
        
        guard let (data, response) = try? await networkClient.load(request: request )
        else {
            throw MusicSearchError.requestFailed
        }
        
        guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode)
        else {
            throw MusicSearchError.networkResponseInvalid
        }
        
        do {
            let musicSearchResponse = try  JSONDecoder().decode(MusicSearchResponse.self, from: data)
            await MainActor.run {
                musicResultList = musicSearchResponse.results
                showAlert = musicSearchResponse.resultCount == 0 ? true : false
            }
            
        } catch {
            throw MusicSearchError.jsonDecodeFailed
        }
    }
    
}
