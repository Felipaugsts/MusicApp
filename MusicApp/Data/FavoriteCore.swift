//
//  FavoriteCore.swift
//  MusicApp
//
//  Created by FELIPE AUGUSTO SILVA on 09/02/22.
//

import Foundation
import UIKit
import CoreData

protocol favoriteProtocol {

    func addFavorite(trackName: String, country: String, artworkUrl100: String, artistName: String)

}

class FavoriteCore: favoriteProtocol {

    
    let context = ( UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
    
    func addFavorite(trackName: String, country: String, artworkUrl100: String, artistName: String) {
        let newItem = Favorites(context: context)
        newItem.trackName = trackName
        newItem.country = country
        newItem.artworkUrl100 = artworkUrl100
        newItem.artistName = artistName
        
        do {
            try context.save()
        }
        catch
        {
            
        }
    }
}
