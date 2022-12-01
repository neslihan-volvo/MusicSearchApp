import Foundation

class ContentViewModel: ObservableObject {
    @Published var musicResultList: [MusicItemModel] = []
    @Published var showAlert = false
    let networkClient : NetworkClient
    
    init(networkClient: NetworkClient = DefaultNetworkClient()) {
        self.networkClient = networkClient
    }
    
    func getMusicList(_ searchKey: String) async throws {
        
        let musicSearchRequest = MusicSearchRequest(searchKey)
        
        guard let (data, response) = try? await networkClient.load(request: musicSearchRequest )
        else {
            throw MusicSearchError.requestFailed
        }
        
        guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode)
        else {
            throw MusicSearchError.networkResponseInvalid
        }
        
        do {
            let musicSearchResponse = try JSONDecoder().decode(MusicSearchResponse.self, from: data)
            await MainActor.run {
                musicResultList = musicSearchResponse.results
                showAlert = musicSearchResponse.resultCount == 0 ? true : false
            }
        } catch {
            throw MusicSearchError.jsonDecodeFailed
        }
    }
}
