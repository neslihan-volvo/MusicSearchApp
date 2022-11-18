//
//  ImageView.swift
//  MusicSearchApp
//
//  Created by Neslihan Doğan Aydemir on 2022-11-15.
//

import SwiftUI

struct MusicListItemView: View {
    var musicItem : MusicListItem
    @State private var songImage = UIImage(systemName: "star")
    var body: some View {
        
        NavigationLink(destination: DetailsView(details: musicItem)){
            HStack{
                Image(uiImage: songImage!)
                    .frame(width: 45, height: 50)
                    .scaledToFill()
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white,lineWidth: 3))
                    .shadow(radius: 5)
                
                VStack(alignment: .leading){
                    
                    Text(musicItem.artistName)
                        .font(.headline)
                    Text(musicItem.trackName)
                        .font(.footnote)
                }
                .onAppear(perform: {
                    Task {
                        await getImage(url: URL(string: musicItem.artworkUrl60)!)
                    }
                })
            }
            
        }
    
    }
    
    func getImage(url:URL) async {
        do {
            //let data = try await downloader.downloadArtwork(at: url)
            let session = URLSession.shared
            let (downloadURL, response) = try await session.download(from: url)
            let data = try Data(contentsOf: downloadURL)
            guard let image = UIImage(data: data) else {
                return
            }
            songImage = image
            } catch {
              print(error)
            }
    }
}

struct MusicListItemView_Previews: PreviewProvider {
    static var previews: some View {
        let musicItemArray = musicListArray
        MusicListItemView(musicItem: musicItemArray[0])
    }
}
