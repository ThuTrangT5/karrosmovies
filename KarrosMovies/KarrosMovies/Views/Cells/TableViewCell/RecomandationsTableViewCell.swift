//
//  RecommendationsTableViewCell.swift
//  KarrosMovies
//
//  Created by ThuTrangT5 on 4/18/20.
//  Copyright © 2020 ThuTrangT5. All rights reserved.
//

import UIKit

class RecommendationsTableViewCell: MoviesTableViewCell {
    
    override class func registerCellToTableView(tableView: UITableView) {
        let identifier = cellIdentifier()
        let bundle = Bundle(for: self.classForCoder())
        let  nib = UINib(nibName: "MoviesTableViewCell", bundle: bundle)
        tableView.register(nib, forCellReuseIdentifier: identifier)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func cellSize() -> CGSize {
        return CGSize(width: 300, height: 160)
    }
    
    override func setupCollectionView() {
        super.setupCollectionView()
        RecomendationCollectionViewCell.registerCellToTableView(collectionView: self.collectionView)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecomendationCollectionViewCell.cellIdentifier(), for: indexPath)
        
        if let movieCell = cell as? RecomendationCollectionViewCell {
            movieCell.movie = self.movies[indexPath.row]
        }
        
        return cell
    }
    
}
