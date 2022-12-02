import Foundation

class ContentViewModel: ObservableObject {
    @Published var state: State = .idle
    @Published var showAlert = false
    
    public enum State: Equatable{
        case idle
        case loading
        case loaded ( results : [MusicItemModel])
        case error
        
        public static func == (lhs: State, rhs: State) -> Bool {
            switch (lhs, rhs){
            case (.idle, .idle):
                return true
            case (.loading, .loading):
                return true
            case (.error, .error):
                return true
            case (.loaded(results: var lhsResults), .loaded(results: var rhsResults)):
                return lhsResults == rhsResults
            default:
                return false
            }
        }
    }
    let networkClient: NetworkClient
    
    init(networkClient: NetworkClient = DefaultNetworkClient()) {
        self.networkClient = networkClient
    }
    
    func loadResults(_ searchKey: String) async {
        let key = searchKey.makeSearchString()
        let urlPath = "https://itunes.apple.com/search?term=\(key)&media=music"
        await MainActor.run {
            state = .loading
        }
        do {
            let (data, response) = try await networkClient.load(path: urlPath)
            guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode)
            else {
                throw MusicSearchError.networkResponseInvalid
            }
            let musicSearchResponse = try JSONDecoder().decode(MusicSearchResponse.self, from: data)
            await MainActor.run {
                state = .loaded(results: musicSearchResponse.results)
            }
        } catch {
            await MainActor.run {
                state = .error
            }
        }
    }
}
