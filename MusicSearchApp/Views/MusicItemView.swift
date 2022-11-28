//
//  ImageView.swift
//  MusicSearchApp
//
//  Created by Neslihan Doğan Aydemir on 2022-11-15.
//
import SwiftUI

struct MusicItemView: View {
    
    var musicItem : MusicItemModel
    @ObservedObject private var imageDownloader = ImageDownloader()
    
    var body: some View {
        
        NavigationLink(destination: DetailsView(details: musicItem)){
            HStack{
                Image(uiImage: imageDownloader.songImage!)
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white,lineWidth: 3))
                    .shadow(radius: 5)
                
                VStack(alignment: .leading){
                    Text(musicItem.artistName)
                        .font(.headline)
                    Text(musicItem.trackName)
                        .font(.footnote)
                }
                .task {
                    await getImage()
                }
            }
        }
    }
    
    func getImage() async {
        do {
            try await imageDownloader.getImage(url: musicItem.artworkUrl60)
        } catch {
            print(error)
        }
    }
}

struct MusicListItemView_Previews: PreviewProvider {
    static var previews: some View {
        MusicItemView(musicItem: item1)
    }
}
