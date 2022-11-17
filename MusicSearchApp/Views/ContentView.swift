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
    @State private var musicResultList: [MusicListItem] = []
    
    var body: some View {
        
        NavigationView(){
            
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
        .onSubmit(of: .search) {
            print("make the request here!!!")
            if !keyword.isEmpty {
                //MusicSearchRequest(term:keyword)
                Task {
                    do {
                        try await getMusicList(searchKey: keyword)
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
    func getMusicList(searchKey:String) async throws {
        let urlPath = "https://itunes.apple.com/search?term=\(searchKey)&media=music"
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        Task {
            let (data, response) = try await session.data(from: URL(string:urlPath)!)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode)
            else {
                throw MusicSearchError.requestFailed
            }
            
            guard let musicSearchResponse = try? JSONDecoder().decode(MusicSearchResponse.self, from: data) else {
                print("decoding went wrong")
                throw MusicSearchError.jsonDecodeFailed
            }
            
            await MainActor.run {
                musicResultList = musicSearchResponse.results
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
