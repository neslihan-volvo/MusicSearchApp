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
        
        NavigationView {
            
            VStack(alignment: .leading){
                TextField("Enter search key",text:$keyword)
                    .onChange(of: keyword) { newValue in
                        if(keyword.count <= 2){
                            //self.alertIsVisible = true
                            self.disabled = true
                            print("button pressed")
                        }
                        else {
                            self.disabled = false
                        }
                    }
                    .onSubmit {
                        // make a request here
                    }
                    .padding()
                    .border(.gray)
                //Button("Search") {
                    //make a request here
                    // if there is an error display it with alert
                    //self.alertIsVisible = true
                //}
                //.disabled(disabled)
                //.padding()
                //.border(.blue)
                //.buttonBorderShape(.roundedRectangle)
                //Details view shoul take specific list items to show detailed data
                NavigationView {
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
                    .navigationBarHidden(true)
                    //.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*0.85)
                    
                }
            }
            .padding()
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        //let musicArray = MusicListItem.mockData()
        ContentView()
    }
}
