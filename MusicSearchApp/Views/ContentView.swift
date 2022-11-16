//
//  ContentView.swift
//  MusicSearchApp
//
//  Created by Neslihan Doğan Aydemir on 2022-11-14.
//

import SwiftUI

struct ContentView: View {
    @State private var keyword : String = ""
    @State private var disabled : Bool = true
    @State private var alertIsVisible : Bool = false
    //@State private var musicListArray: [MusicListItem]
    
    var body: some View {
        
        NavigationView() {
            
                    List(musicListArray) { musicItem in
                        //search results in a list
                        NavigationLink(destination: DetailsView(details: musicItem)){
                            VStack(alignment: .leading){
                                
                                Text(musicItem.artistName)
                                    .font(.headline)
                                Text(musicItem.collectionName)
                                    .font(.subheadline)
                            }
                        }
                    }
                    //.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*0.85)
           
        }
        .searchable(text: $keyword, placement: .navigationBarDrawer(displayMode: .always)){
            
        
        }
        /*.onChange(of: keyword) { keyword in

            if !keyword.isEmpty {
                //if there is keyword make the request after enter pressed
                musicListArray = musicListArray.filter { $0.artistName.contains(keyword) || $0.collectionName.contains(keyword)}
            } else {
                //if keyword is empty there do nothing
            }
        }*/
        .onSubmit(of: .search) {
            print("make the request here!!!")
            if !keyword.isEmpty {
                //add the keyword to reuest and call network request here
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        //let musicArray = MusicListItem.mockData()
        ContentView()
    }
}
