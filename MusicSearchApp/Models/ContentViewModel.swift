import Foundation

class ContentViewModel: ObservableObject {
    @Published var musicResultList: [MusicListItem] = []
    @Published var showAlert = false
    
    func getMusicList(searchKey: String) async throws -> MusicSearchResponse {
        let urlPath = "https://itunes.apple.com/search?term=\(searchKey)&media=music"
        let session = URLSession.shared
        let (data, response) = try await session.data(from: URL(string:urlPath)!)
        
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
