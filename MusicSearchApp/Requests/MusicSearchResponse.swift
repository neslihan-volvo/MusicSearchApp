//
//  MusicSearchResponse.swift
//  MusicSearchApp
//
//  Created by Neslihan Doğan Aydemir on 2022-11-16.
//
import Foundation

public struct MusicSearchResponse: Codable {
    public var resultCount : Int
    public var results : [MusicListItem]
    
}
