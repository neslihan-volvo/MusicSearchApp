//
//  DetailsView.swift
//  MusicSearchApp
//
//  Created by Neslihan Doğan Aydemir on 2022-11-15.
//
import SwiftUI
import AVKit

struct DetailsView: View {
    
    var details: MusicItemModel
    @State private var musicPlayer = AVPlayer()
    @State private var downloaded = false
    @State private var image = UIImage()
    
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
            Button("Play Music") {
                play()
                // add new functions to handle playing music.
                // for now it does not stop when we go back or no stop button.
                // there is a function to stop -> .stop
            }
            .padding()
            .font(.title)
            Spacer()
            Text(details.collectionName)
                .font(.title2)
            HStack{
                //Text(String(details.collectionPrice)).font(.footnote)
                //Text(String(details.currency)).font(.footnote)
            }
        }
        .task { 
            await getImage()
        }
        
    }
    
    func getImage() async {
        do {
            image = try await imageDownloader.getImage(url: details.artworkUrl100)
        } catch {
            print(error)
        }
    }
    
    func play(){
        musicPlayer = AVPlayer(url: URL(string: details.previewUrl)!)
        musicPlayer.play()
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(details: item1)
    }
}





