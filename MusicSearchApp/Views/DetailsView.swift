import SwiftUI
import AVKit

struct DetailsView: View {
    
    var details: MusicItemModel
    private let musicPlayer = AVPlayer()
    @State var buttonText = "Play"
    
    var body: some View {
        VStack{
            Spacer()
            AsyncImage(url: URL(string: details.artworkUrl100)) { image in
                image.resizable()
                    .frame(width:200,height:200)
                    .overlay(Rectangle().stroke(Color.white,lineWidth: 3))
                    .shadow(radius: 8)
                    .padding()
            } placeholder: {
                ProgressView()
            }
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
                .lineLimit(3)
                .font(.title2)
            
            Spacer()
        }
        .onDisappear(perform: {
            musicPlayer.pause()
        })
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
