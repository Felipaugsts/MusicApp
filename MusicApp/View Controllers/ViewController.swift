//
//  ViewController.swift
//  MusicApp
//
//  Created by FELIPE AUGUSTO SILVA on 08/02/22.
//
import SDWebImage
import UIKit

class ViewController: UIViewController, UISearchBarDelegate {
    
    private lazy var artistModel: MusicViewModel = AppContainer.shared.resolve(MusicViewModel.self)!
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    @IBOutlet weak var MusicCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        MusicCollectionView.register(UINib(nibName: "MusicCVCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    }

    override func viewDidAppear(_ animated: Bool) {
        artistModel.onShowMusic = {
            DispatchQueue.main.async {
                self.MusicCollectionView.reloadData()
                self.loadingSpinner.stopAnimating()
            }
        }
        self.loadingSpinner.startAnimating()
        artistModel.fetchMusic(Artist: "James")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let field = searchBar.text ?? ""
        artistModel.fetchMusic(Artist: field.lowercased())
        self.loadingSpinner.startAnimating()
        searchBar.resignFirstResponder()
    }

}


extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return artistModel.MusicFetched.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = MusicCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MusicCVCell
        let info = self.artistModel.MusicFetched
        
        cell.imageView.sd_setImage(with: URL(string: info[indexPath.row].artworkUrl100), placeholderImage: UIImage(named: "placeholder.png"))
        
        cell.bandTitle.text = "\(info[indexPath.row].artistName)"
        cell.musicTitle.text = "\(info[indexPath.row].trackName)"
        return cell
    }
}

