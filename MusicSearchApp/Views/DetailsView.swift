//
//  DetailsView.swift
//  MusicSearchApp
//
//  Created by Neslihan Doğan Aydemir on 2022-11-15.
//
import SwiftUI
import AVKit

struct DetailsView: View {
    
    var details: MusicListItem
    @State private var songImage = UIImage(systemName: "star")
    @State private var musicPlayer = AVAudioPlayer()
    @State private var downloaded = false
    
    @ObservedObject private var imageDownloader = ImageDownloader()
    @ObservedObject private var musicDownloader = MusicDownloader()
    
    var body: some View {
        VStack{
            Spacer()
            Image(uiImage: songImage!)
                .frame(width: 150, height: 150)
                .scaledToFill()
                .overlay(Rectangle().stroke(Color.white,lineWidth: 3))
                .shadow(radius: 8)
                .padding()
            Text(details.artistName)
                .font(.title)
            Text(details.trackName)
                .font(.title)
            Button("Play Music") {
                //play()
            }
            .padding()
            .font(.title)
            Spacer()
            Text(details.collectionName)
                .font(.title2)
            HStack{
                Text(String(details.collectionPrice)).font(.footnote)
                Text(String(details.currency)).font(.footnote)
            }
        }
        .onAppear(perform: {
            Task {
                await getImage()
                //await getMusic()
            }
        })
    }
    func getImage() async {
        guard let imageURL = URL(string: details.artworkUrl100) else {
            return
        }
        do {
            let image = try await imageDownloader.downloadImage(url: imageURL)
            songImage = image
        } catch {
          print(error)
        }
        
    }
    func getMusic() async {
        if musicDownloader.downloadLocation == nil {
            downloaded = false
            guard let previewURL = URL(string: details.previewUrl) else {
                return
            }
            do {
                try await musicDownloader.downloadMusic(url: previewURL)
            } catch {
                print(error)
            }
        } else {
            downloaded = true
        }
    }
    func play(){
        do{
            musicPlayer = try AVAudioPlayer(contentsOf: musicDownloader.downloadLocation!)
            musicPlayer.play()
        }catch{
            print(error)
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        
        DetailsView(details: item1)
    }
}





