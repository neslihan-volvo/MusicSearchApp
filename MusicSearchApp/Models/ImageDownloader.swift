import SwiftUI

class ImageDownloader: ObservableObject{
    
    @Published var songImage = UIImage(systemName: "star")
    
    enum ImageDownloaderError: Error {
        case imageDownloadFailed
        case imageInitializationFailed
        case networkResponseInvalid
    }

    let networkClient : NetworkClient
    
    init(networkClient: NetworkClient = DefaultNetworkClient()) {
        self.networkClient = networkClient
    }
    
    /*func downloadImage(url: URL) async throws -> UIImage {
        
        let (data, response) = try await session.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode)
        else {
            throw ImageDownloaderError.networkResponseInvalid
        }
        guard let image = UIImage(data: data)
        else {
            throw ImageDownloaderError.imageInitializationFailed
        }
        return image
        
    }*/
    func getImage(url: String) async throws{
        guard let imageURL = URL(string: url)
        else {
            return
        }
        let request = URLRequest(url: imageURL)
       
        guard let (data, response) = try? await networkClient.load(request: request)
        else {
            throw ImageDownloaderError.imageDownloadFailed
        }

        guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode)
        else {
            throw ImageDownloaderError.networkResponseInvalid
        }
        
        guard let image = UIImage(data: data)
        else {
            throw ImageDownloaderError.imageInitializationFailed
        }
        
        await MainActor.run {
            songImage = image
        }
        
    }
    
    
}
