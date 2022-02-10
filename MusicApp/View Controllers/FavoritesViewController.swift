//
//  FavoritesViewController.swift
//  MusicApp
//
//  Created by FELIPE AUGUSTO SILVA on 09/02/22.
//

import UIKit
import CoreData
import SDWebImage

class FavoritesViewController: UIViewController {
    let context = ( UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
    public lazy var FavoriteModel: FavoriteViewModel = AppContainer.shared.resolve(FavoriteViewModel.self)!
    @IBOutlet weak var FavoriteCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FavoriteCollectionView.register(UINib(nibName: "MusicCVCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        FavoriteModel.FetchFavorites()
        FavoriteCollectionView.reloadData()
    }

}

extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FavoriteModel.result.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = FavoriteCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MusicCVCell
        let results = FavoriteModel.result[indexPath.row]
        cell.imageView.sd_setImage(with: URL(string: results.artworkUrl100), placeholderImage: UIImage(named: "placeholder.png"))
        cell.bandTitle.text = results.artistName
        cell.musicTitle.text = results.trackName
        cell.FavButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected", FavoriteModel.result[indexPath.row])
    }
    
    
 
}
