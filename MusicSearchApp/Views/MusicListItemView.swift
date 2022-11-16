//
//  ImageView.swift
//  MusicSearchApp
//
//  Created by Neslihan Doğan Aydemir on 2022-11-15.
//

import SwiftUI

struct MusicListItemView: View {
    var musicItem : MusicListItem
    var body: some View {
        Text(musicItem.collectionName)
    }
}

struct MusicListItemView_Previews: PreviewProvider {
    static var previews: some View {
        let musicItemArray = musicListArray
        MusicListItemView(musicItem: musicItemArray[0])
    }
}
