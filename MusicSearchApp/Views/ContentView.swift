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
    var body: some View {
        VStack {
            TextField("Enter search key",text:$keyword)
                .onChange(of: keyword) { newValue in
                    if(keyword.count <= 2){
                        self.disabled = true
                        
                    }
                    else {
                        self.disabled = false
                    }
                }
            Button("Search") {
                //make a request here
                // if there is an error display it with alert
                //self.alertIsVisible = true
            }
            .disabled(disabled)
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
