import SwiftUI

class ImageDownloader: ObservableObject{
    
    @Published var songImage = UIImage(systemName: "star")
    
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
        
        let (data, response) = try await session.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200
        else {
            throw ImageDownloaderError.networkResponseInvalid
        }
        guard let image = UIImage(data: data)
        else {
            throw ImageDownloaderError.imageInitializationFailed
        }
        return image
        
    }
    func getImage(url: String) async throws{
        guard let imageURL = URL(string: url) else {
            return
        }
        do {
            let image = try await downloadImage(url: imageURL)
            await MainActor.run {
                songImage = image
            }
        } catch {
            throw error
        }
        
    }
    
    
}
