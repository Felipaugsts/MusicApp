//
//  MusicModel.swift
//  MusicApp
//
//  Created by FELIPE AUGUSTO SILVA on 09/02/22.
//

import Foundation

struct Music:  Decodable {
    let results: [Artist]
}

struct Artist: Decodable {
    let artistId: Int
    let artistName: String
    let artworkUrl100: String
    let country: String
    let trackName: String
    
}
