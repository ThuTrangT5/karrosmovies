//
//  MoviesTableViewCell.swift
//  KarrosMovies
//
//  Created by ThuTrangT5 on 4/18/20.
//  Copyright © 2020 ThuTrangT5. All rights reserved.
//

import UIKit

class MoviesTableViewCell: UITableViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource  {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies: [MovieModel] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    private var cellSize = CGSize(width: 150, height: 270)
    var handleLoadMore: (() -> Void)?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.setupCollectionView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
//        self.collectionView.layoutIfNeeded()
        return cellSize
    }
    
    func setupCollectionView() {
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.backgroundColor = UIColor.clear
        self.collectionView.layer.masksToBounds = false
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.isScrollEnabled = true
        
        if let flow = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flow.minimumLineSpacing = 0
            flow.minimumInteritemSpacing = 10
            flow.estimatedItemSize = CGSize.zero
            flow.scrollDirection = .horizontal
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellMovie", for: indexPath)
        
        if let movieCell = cell as? MovieCollectionViewCell {
            movieCell.movie = self.movies[indexPath.row]
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == self.movies.count - 1 {
            //last cell
            self.handleLoadMore?()
        }
    }
}
