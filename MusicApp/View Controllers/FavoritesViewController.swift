//
//  FavoritesViewController.swift
//  MusicApp
//
//  Created by FELIPE AUGUSTO SILVA on 09/02/22.
//

import UIKit
import CoreData

class FavoritesViewController: UIViewController {
    let context = ( UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
    public lazy var FavoriteModel: FavoriteViewModel = AppContainer.shared.resolve(FavoriteViewModel.self)!

    var result:[Favorites] = []

    @IBOutlet weak var FavoriteCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FavoriteCollectionView.register(UINib(nibName: "MusicCVCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        FetchFavorites()
        FavoriteCollectionView.reloadData()
    }

}

extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return result.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = FavoriteCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MusicCVCell
        let results = result[indexPath.row]
        
        cell.bandTitle.text = results.artistName
        cell.musicTitle.text = results.trackName
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected", result[indexPath.row])
    }
    
    
    func FetchFavorites() {
        let request = NSFetchRequest<Favorites>(entityName: "Favorites")
        
        do {
            result = try context.fetch(request)
        }
        catch
        {
    }
    
}
}
