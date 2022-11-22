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
    @State private var showAlert = false
    private var contentVC = ContentViewController()
    var body: some View {
        
        NavigationView(){
            List(musicResultList) { musicItem in
                MusicListItemView(musicItem: musicItem)
                .listRowSeparator(.hidden)
            }
        }
        .alert("There is no search result. Plese try another keyword.", isPresented: $showAlert) {
          Button("Dismiss", role: .cancel) { showAlert = false } }
        .searchable(text: $keyword, placement: .navigationBarDrawer(displayMode: .always)){}
        .onSubmit(of: .search) {
            if !keyword.isEmpty {
                Task {
                    await getMusicList()
                }
            }
        }
    }
    public func getMusicList() async throws{
        
        let searchString = keyword.createSearchString()
        do {
            let result = try await contentVC.getMusicList(searchKey: searchString)
            await MainActor.run {
                musicResultList = result.results
                showAlert = result.resultCount == 0 ? true : false
            }
        } catch {
            print(error)
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        ContentView()
    }
}
