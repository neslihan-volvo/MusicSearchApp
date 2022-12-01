import Foundation

protocol NetworkClient: AnyObject {
    func load(request: MusicSearchRequest) async throws -> (Data, URLResponse)
}

class DefaultNetworkClient: NetworkClient {
    
    func load(request: MusicSearchRequest) async throws -> (Data, URLResponse) {
        guard let url = URL(string: request.urlPath)
        else {
            throw MusicSearchError.urlInvalid
        }
        let request = URLRequest(url: url)
        let session = URLSession.shared
        return try await session.data(for: request)
    }
}
