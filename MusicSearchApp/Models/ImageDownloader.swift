import SwiftUI

class ImageDownloader: ObservableObject{
    
    enum ImageDownloaderError: Error {
        case imageDownloadFailed
        case imageInitializationFailed
        case networkResponseInvalid
    }

    private let session: URLSession

    init() {
        self.session = URLSession.shared
    }
    
    func downloadImage(url: URL) async throws -> UIImage {
        let (downloadURL, response) = try await session.download(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200
        else {
            throw ImageDownloaderError.networkResponseInvalid
        }
        guard let data = try? Data(contentsOf: downloadURL)
        else{
            throw ImageDownloaderError.imageDownloadFailed
        }
        guard let image = UIImage(data: data)
        else {
            throw ImageDownloaderError.imageInitializationFailed
        }
        return image
        
    }
    
    
}
