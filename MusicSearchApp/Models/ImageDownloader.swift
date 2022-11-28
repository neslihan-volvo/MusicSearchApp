import SwiftUI

class ImageDownloader{

    enum ImageDownloaderError: Error {
        case imageDownloadFailed
        case imageInitializationFailed
        case networkResponseInvalid
        case urlInvalid
    }

    let networkClient : NetworkClient
    
    init(networkClient: NetworkClient = DefaultNetworkClient()) {
        self.networkClient = networkClient
    }
    
    func getImage(url: String) async throws -> UIImage{
        guard let imageURL = URL(string: url)
        else {
            throw ImageDownloaderError.urlInvalid
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
        
        return image
        
    }
    
    
}
