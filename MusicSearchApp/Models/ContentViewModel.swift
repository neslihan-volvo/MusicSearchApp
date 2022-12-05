import Foundation
import Combine

class ContentViewModel: ObservableObject {
    @Published var state: State = .idle
    @Published var showAlert = false
    @Published var keyword = ""
    public enum State: Equatable {
        
        
        case idle
        case loading
        case loaded ( results : [MusicItemModel])
        case error
        // 2.way of getting results
        var results: [MusicItemModel]? {
            switch self {
            case .loaded(results: let result):
                return result
            default:
                return nil
            }
        }
    }
    let networkClient: NetworkClient
    private var disposables = Set<AnyCancellable>()
    private var disposable: AnyCancellable?
    
    init(networkClient: NetworkClient = DefaultNetworkClient()) {
        self.networkClient = networkClient
        $keyword
            .debounce(for: .milliseconds(800), scheduler: RunLoop.main)
            .sink { completion in
                switch completion{
                case .finished:
                    print("successfully finished")
                case .failure:
                    print("failed")
                }
            } receiveValue: { [self] searchKey in
                Task {
                    await loadResults(searchKey)
                }
            }
            .store(in: &disposables)
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
