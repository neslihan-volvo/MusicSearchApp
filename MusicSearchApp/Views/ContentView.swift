import SwiftUI

struct ContentView: View {
    @State private var keyword = ""
    @ObservedObject private var viewModel = ContentViewModel()
    
    var body: some View {
        
        NavigationView() {
            List(viewModel.musicResultList) { musicItem in
                MusicItemView(musicItem: musicItem)
                .listRowSeparator(.hidden)
            }
        }
        .alert("There is no search result. Plese try another keyword.", isPresented: $viewModel.showAlert) {
            Button("Dismiss", role: .cancel) { viewModel.showAlert = false } }
        .searchable(text: $keyword, placement: .navigationBarDrawer(displayMode: .always)){}
        .onSubmit(of: .search) {
            if !keyword.isEmpty {
                Task {
                    try await viewModel.getMusicList(keyword)
                }
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        ContentView()
    }
}
