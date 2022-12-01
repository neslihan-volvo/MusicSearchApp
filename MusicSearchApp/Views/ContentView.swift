import SwiftUI
struct ContentView: View {
    @State private var keyword = ""
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
                Text("Unable to load")
            case .loading:
                ProgressView("Loading")
            case .idle:
                Text("Waiting for an input.")
            }
        }
        .searchable(text: $keyword, placement: .navigationBarDrawer(displayMode: .always))
        .onSubmit(of: .search) {
            Task {
                await viewModel.loadResults(keyword)
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
