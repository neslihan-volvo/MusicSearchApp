import SwiftUI

struct MusicItemView: View {
    
    let musicItem : MusicItemModel
    
    var body: some View {
        
        NavigationLink(destination: DetailsView(details: musicItem)){
            HStack{
                AsyncImage(url: URL(string: musicItem.artworkUrl60)) { image in
                    image.frame(width: 60, height: 60)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white,lineWidth: 3))
                        .shadow(radius: 5)
                } placeholder: {
                    ProgressView()
                }
                VStack(alignment: .leading){
                    Text(musicItem.artistName)
                        .font(.headline)
                    Text(musicItem.trackName)
                        .font(.footnote)
                }
            }
        }
    }
}

struct MusicListItemView_Previews: PreviewProvider {
    static var previews: some View {
        MusicItemView(musicItem: item)
    }
}
