//
//  favoriteViewModel.swift
//  MusicApp
//
//  Created by FELIPE AUGUSTO SILVA on 09/02/22.
//

import Foundation
import UIKit
import CoreData


class FavoriteViewModel {
    let context = ( UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
    
    public let core: favoriteProtocol
    
    init(core: favoriteProtocol) {
        self.core = core
    }
    
    public func addToFavorite(trackName: String, country: String, artworkUrl100: String, artistName: String) {
        core.addFavorite(trackName: trackName, country: country, artworkUrl100: artworkUrl100, artistName: artistName)
    }
}
