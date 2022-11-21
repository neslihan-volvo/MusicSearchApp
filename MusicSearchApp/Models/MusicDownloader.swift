import SwiftUI

class MusicDownloader:ObservableObject{
    
    private let session: URLSession
    @Published var downloadLocation: URL?
    
    enum MusicDownloaderError: Error {
        case downloadDirectoryError
        case musicDownloadFailed
        case networkResponseInvalid
    }
    
    init() {
        self.session = URLSession.shared
    }
    
    func downloadMusic(url:URL) async throws{
        let (downloadURL, response) = try await session.download(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200
        else {
            throw MusicDownloaderError.networkResponseInvalid
        }
        let fileManager = FileManager.default
        guard let downloadPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        else {
            throw MusicDownloaderError.downloadDirectoryError
        }
        
        let lastPathComponent = url.lastPathComponent
        let destinationURL = downloadPath.appendingPathComponent(lastPathComponent)
        do {
            if fileManager.fileExists(atPath: destinationURL.path) {
                try fileManager.removeItem(at: destinationURL)
            }

            try fileManager.copyItem(at: downloadURL, to: destinationURL)
        }
        catch {
            print("Failed to store the song.")
            throw MusicDownloaderError.musicDownloadFailed
        }
        await MainActor.run {
          downloadLocation = destinationURL
        }
    }
}
