//
//  FavoritesViewController.swift
//  MusicApp
//
//  Created by FELIPE AUGUSTO SILVA on 09/02/22.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var FavoriteCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        MusicCollectionView.register(UINib(nibName: "MusicCVCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        FavoriteCollectionView.register(UINib(nibName: "MusicCVCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    }

}

extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = FavoriteCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MusicCVCell
        
        return cell
    }
    
    
}
