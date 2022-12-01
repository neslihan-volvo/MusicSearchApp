import SwiftUI
import AVKit

struct DetailsView: View {
    
    var details: MusicItemModel
    private let musicPlayer = AVPlayer()
    @State private var image = UIImage()
    @State var buttonText = "Play"
    var imageDownloader = ImageDownloader()
    
    var body: some View {
        VStack{
            Spacer()
            Image(uiImage: image)
                .frame(width: 150, height: 150)
                .scaledToFill()
                .overlay(Rectangle().stroke(Color.white,lineWidth: 3))
                .shadow(radius: 8)
                .padding()
            Text(details.artistName)
                .font(.title)
            Text(details.trackName)
                .font(.title)
            Button(buttonText) {
                play()
            }
            .padding()
            .font(.title)
            Spacer()
            Text(details.collectionName)
                .font(.title2)
        }
        .task {
            await getImage()
        }
        .onDisappear(perform: {
            musicPlayer.pause()
        })
    }
    
    func getImage() async {
        do {
            image = try await imageDownloader.getImage(url: details.artworkUrl100)
        } catch {
            print(error)
        }
    }
    
    func play(){
        if musicPlayer.rate == 1 {
            musicPlayer.pause()
            buttonText = "Play"
        }else{
            if musicPlayer.currentItem == nil {
                musicPlayer.replaceCurrentItem(with: AVPlayerItem(url: URL(string: details.previewUrl)!))
            }
            musicPlayer.play()
            buttonText = "Pause"
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(details: item)
    }
}
