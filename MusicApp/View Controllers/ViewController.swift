//
//  ViewController.swift
//  MusicApp
//
//  Created by FELIPE AUGUSTO SILVA on 08/02/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var MusicCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        MusicCollectionView.register(UINib(nibName: "MusicCVCell", bundle: nil), forCellWithReuseIdentifier: "cell")
 
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = MusicCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MusicCVCell

        return cell
    }
}


