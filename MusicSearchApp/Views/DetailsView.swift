//
//  DetailsView.swift
//  MusicSearchApp
//
//  Created by Neslihan Doğan Aydemir on 2022-11-15.
//

import SwiftUI

struct DetailsView: View {
    var details: MusicListItem
    
    var body: some View {
        VStack{
            
            Text(details.artistName)
            Text(details.collectionName)
            // there should be an extension to download image data from specified url
            //add more detail
            //add play option for preview
        }
        
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let details: MusicListItem = MusicListItem(id:4677, wrapperType: WrapperType.track, kind: "song", artistId: 1234, artistName: "Jack Johnson", collectionName: "Sing-a-Longs and Lullabies for the Film Curious George", trackName: "Upside Down", artistViewUrl: "https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewArtist?id=909253", collectionViewUrl: "https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewAlbum?i=120954025&id=120954021&s=143441", previewUrl: "http://a1099.itunes.apple.com/r10/Music/f9/54/43/mzi.gqvqlvcq.aac.p.m4p", artworkUrl60: "http://a1.itunes.apple.com/r10/Music/3b/6a/33/mzi.qzdqwsel.60x60-50.jpg", artworkUrl100: "http://a1.itunes.apple.com/r10/Music/3b/6a/33/mzi.qzdqwsel.100x100-75.jpg", collectionPrice: 10.99, trackPrice: 0.99, currency: "USD")
        DetailsView(details:details)
    }
}
