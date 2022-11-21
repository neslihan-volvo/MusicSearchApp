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
    @ObservedObject private var downloader = ImageDownloader()
    
    var body: some View {
        
        NavigationLink(destination: DetailsView(details: musicItem)){
            HStack{
                Image(uiImage: songImage!)
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
                .onAppear(perform: {
                    Task {
                        await getImage()
                    }
                })
            }
        }
    }
    
    func getImage() async {
        guard let imageURL = URL(string: musicItem.artworkUrl60) else {
            return
        }
        do {
            let image = try await downloader.downloadImage(url: imageURL)
            songImage = image
        } catch {
            print(error)
        }
    }
}

struct MusicListItemView_Previews: PreviewProvider {
    static var previews: some View {
        MusicListItemView(musicItem: item1)
    }
}
