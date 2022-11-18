//
//  ContentView.swift
//  MusicSearchApp
//
//  Created by Neslihan Doğan Aydemir on 2022-11-14.
//
import SwiftUI

struct ContentView: View {
    @State private var keyword : String = ""
    @State private var musicResultList: [MusicListItem] = []
    
    var body: some View {
        
        NavigationView(){
            List(musicResultList) { musicItem in
                MusicListItemView(musicItem: musicItem)
                .listRowSeparator(.hidden)
            }
        }
        .searchable(text: $keyword, placement: .navigationBarDrawer(displayMode: .always)){}
        .onSubmit(of: .search) {
            if !keyword.isEmpty {
                let searchString = createSearchString(string: keyword)
                Task {
                    do {
                        try await getMusicList(searchKey: searchString)
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
    
    func getMusicList(searchKey:String) async throws {
        
        let urlPath = "https://itunes.apple.com/search?term=\(searchKey)&media=music"
        let session = URLSession.shared
        let (data, response) = try await session.data(from: URL(string:urlPath)!)
        
        guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode)
        else {
            throw MusicSearchError.requestFailed
        }
        do {
            let musicSearchResponse = try  JSONDecoder().decode(MusicSearchResponse.self, from: data)
            await MainActor.run {
                musicResultList = musicSearchResponse.results
            }
        }catch {
            throw error
        }
    }
    
    func createSearchString(string:String)-> String{
        let trimmedString = string.trimmingCharacters(in: .whitespacesAndNewlines)
        let searchString = String(trimmedString.map {
            $0 == " " ? "+" : $0
        })
        return searchString
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        //let musicArray = MusicListItem.mockData()
        ContentView()
    }
}
