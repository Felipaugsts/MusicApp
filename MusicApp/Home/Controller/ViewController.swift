//
//  ViewController.swift
//  MusicApp
//
//  Created by FELIPE AUGUSTO SILVA on 08/02/22.
//
import SDWebImage
import UIKit

class ViewController: UIViewController, UISearchBarDelegate{
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    public lazy var artistModel: MusicViewModel = AppContainer.shared.resolve(MusicViewModel.self)!
    public lazy var favoriteModel: FavoriteViewModel = AppContainer.shared.resolve(FavoriteViewModel.self)!
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    @IBOutlet weak var MusicCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        searchBar.delegate = self
        MusicCollectionView.register(UINib(nibName: "MusicCVCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    }

    override func viewDidAppear(_ animated: Bool) {
        favoriteModel.FetchFavorites()
        artistModel.onShowMusic = {
            DispatchQueue.main.async {
                self.MusicCollectionView.reloadData()
                self.loadingSpinner.stopAnimating()
                self.view.isUserInteractionEnabled = true
            }
        }
        self.loadingSpinner.startAnimating()
        artistModel.fetchMusic(Artist: "James")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let field = searchBar.text ?? ""
        if field.isEmpty {
            searchBar.resignFirstResponder()
        } else {
        let trimmed = field.replacingOccurrences(of: " ", with: "")
        artistModel.fetchMusic(Artist: trimmed.lowercased())
        self.loadingSpinner.startAnimating()
        searchBar.resignFirstResponder()
        self.view.isUserInteractionEnabled = false
        }
    }

}


extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return artistModel.MusicFetched.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = MusicCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MusicCVCell
        let info = self.artistModel.MusicFetched[indexPath.row]
        
        cell.imageView.sd_setImage(with: URL(string: info.artworkUrl100), placeholderImage: UIImage(named: "placeholder.png"))
        
        var icon: String = ""
        filterFavorites(index: indexPath.row, completion: { (result) in
            print("results", result)
            icon = result
        })
        cell.FavButton.setImage(UIImage(systemName: icon), for: .normal)
        icon = ""
        cell.bandTitle.text = "\(info.artistName)"
        cell.musicTitle.text = "\(info.trackName)"
        cell.FavButton.addTarget(self, action: #selector(addToFavorite(sender:)), for: .touchUpInside)
        return cell
    }
    
    @objc func addToFavorite(sender: UIButton) {
        var superview = sender.superview
        while let view = superview, !(view is UICollectionViewCell) {
            superview = view.superview
        }
        guard let cell = superview as? UICollectionViewCell else {
            print("button is not contained in a table view cell")
            return
        }
        guard let indexPath = MusicCollectionView.indexPath(for: cell) else {
            print("failed to get index path for cell containing button")
            return
        }
        // We've got the index path for the cell that contains the button, now do something with it.
        let ind = artistModel.MusicFetched[indexPath.row]
//        self.MusicCollectionView.reloadData()
//        MusicCollectionView.reloadData()
        print("test: \(ind)")
        
        
        favoriteModel.addToFavorite(trackName: ind.trackName, country: ind.country, artworkUrl100: ind.artworkUrl100, artistName: ind.artistName)
    }
    
    func filterFavorites(index: Int, completion: (_ result: String ) -> Void) {
        print("idx", index)
        completion("test")
        let favorites = favoriteModel.result
        let items = artistModel.MusicFetched[index]
        
        for i in favorites {
            if i.trackName == items.trackName{
                completion("heart.fill")
            } else {
                completion("heart")
            }
        }
    }
    
}

    
