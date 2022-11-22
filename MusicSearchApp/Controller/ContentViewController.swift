//
//  ContentViewController.swift
//  MusicSearchApp
//
//  Created by Neslihan Doğan Aydemir on 2022-11-22.
//

import UIKit

class ContentViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    public func getMusicList(searchKey:String) async throws -> MusicSearchResponse{
        
        
        let urlPath = "https://itunes.apple.com/search?term=\(searchKey)&media=music"
        let session = URLSession.shared
        let (data, response) = try await session.data(from: URL(string:urlPath)!)
        
        guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode)
        else {
            throw MusicSearchError.requestFailed
        }
        do {
            let musicSearchResponse = try  JSONDecoder().decode(MusicSearchResponse.self, from: data)
            return musicSearchResponse
            
        }catch {
            throw error
        }
    }

}
