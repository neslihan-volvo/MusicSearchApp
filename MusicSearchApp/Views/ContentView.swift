import SwiftUI
struct ContentView: View {
    @ObservedObject private var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationView() {
            switch viewModel.state{
            case .loaded(results: let results):
                List(results) { musicItem in
                    MusicItemView(musicItem: musicItem)
                        .listRowSeparator(.hidden)
                }
            case .error:
                Text("Unable to load try another keyword")
            case .loading:
                ProgressView("Loading")
            case .idle:
                Text("Waiting for an input.")
            }
        }
        .searchable(text: $viewModel.keyword, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search for music")
    }
    
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
