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
            
            List(musicResultList) { musicItem in
                NavigationLink(destination: DetailsView(details: musicItem)){
                    VStack(alignment: .leading){
                        
                        Text(musicItem.artistName)
                            .font(.headline)
                        Text(musicItem.collectionName)
                            .font(.subheadline)
                    }
                }
            }
        }
        .searchable(text: $keyword, placement: .navigationBarDrawer(displayMode: .always)){}
        .onSubmit(of: .search) {
            print("make the request here!!!")
            if !keyword.isEmpty {
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
        let urlPath = "https://itunes.apple.com/search?term=\(searchKey)&limit=10&media=music"
        
        let session = URLSession.shared
        
            let (data, response) = try await session.data(from: URL(string:urlPath)!)
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode)
            else {
                throw MusicSearchError.requestFailed
            }
            print("JSON String: \(String(data: data, encoding: .utf8) ??  "no data here")")
            do {
                let musicSearchResponse = try  JSONDecoder().decode(MusicSearchResponse.self, from: data)
                await MainActor.run(body: {
                    musicResultList = musicSearchResponse.results
                })
            }catch {
                throw error
            }
            
            
        
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        //let musicArray = MusicListItem.mockData()
        ContentView()
    }
}
