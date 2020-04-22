//
//  MoviesTableViewCell.swift
//  KarrosMovies
//
//  Created by ThuTrangT5 on 4/18/20.
//  Copyright © 2020 ThuTrangT5. All rights reserved.
//

import UIKit

class MoviesTableViewCell: BaseTableViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource  {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movieType: MovieListSectionType = .popular
    var movies: [MovieModel] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    //    var cellSize = CGSize(width: 150, height: 270)
    var handleLoadMore: (() -> Void)?
    var handleDidSelectMovie: ((NSNumber)->Void)?
    
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
    
    
    func cellSize() -> CGSize {
        if self.movieType == .recommendation {
            return CGSize(width: 300, height: 160)
        }
        
        return CGSize(width: 150, height: 270)
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        return cellSize()
    }
    
    func setupCollectionView() {
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.backgroundColor = UIColor.clear
        self.collectionView.layer.masksToBounds = false
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.isScrollEnabled = true
        
        MovieCollectionViewCell.registerCellToTableView(collectionView: self.collectionView)
        RecomendationCollectionViewCell.registerCellToTableView(collectionView: self.collectionView)
        
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
        return cellSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if self.movieType == .recommendation {
            return self.recommendationCell(indexPath: indexPath)
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.cellIdentifier(), for: indexPath)
        
        if let movieCell = cell as? MovieCollectionViewCell {
            movieCell.movie = self.movies[indexPath.row]
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        if indexPath.row < self.movies.count,
            let selectedMovieID = self.movies[indexPath.row].movieID {
            self.handleDidSelectMovie?(selectedMovieID)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == self.movies.count - 1 {
            //last cell
            self.handleLoadMore?()
        }
    }
    
    private func recommendationCell(indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecomendationCollectionViewCell.cellIdentifier(), for: indexPath)
        
        if let movieCell = cell as? RecomendationCollectionViewCell {
            movieCell.movie = self.movies[indexPath.row]
        }
        
        return cell
    }
}
