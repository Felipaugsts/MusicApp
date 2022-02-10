//
//  Favorite+CoreDataClass.swift
//  MusicApp
//
//  Created by FELIPE AUGUSTO SILVA on 09/02/22.
//

import CoreData

@objc(Favorites)
public class Favorites: NSManagedObject {
    
}

extension Favorites {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorites> {
        return NSFetchRequest<Favorites>(entityName: "Favorites")
    }
    @NSManaged var artistId: Int64
    @NSManaged var artistName: String
    @NSManaged var artworkUrl100: String
    @NSManaged var country: String
    @NSManaged var trackName: String
}

extension Favorites: Identifiable {
}
