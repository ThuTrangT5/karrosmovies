//
//  RecommendationCollectionViewCell.swift
//  KarrosMovies
//
//  Created by ThuTrangT5 on 4/18/20.
//  Copyright © 2020 ThuTrangT5. All rights reserved.
//

import UIKit
import Kingfisher

class RecomendationCollectionViewCell: BaseCollectionViewCell {
    
    @IBOutlet weak var imageViewPlaceholder: UIImageView!
    @IBOutlet weak var imageViewBackdrop: UIImageView!
    
    
    var movie: MovieModel? {
        didSet {
            self.bindData(movie: movie)
        }
    }
    
    func bindData(movie: MovieModel?) {
        self.imageViewBackdrop.kf.cancelDownloadTask()
        self.imageViewBackdrop.kf.setImage(with: movie?.backdropURL)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageViewPlaceholder.layer.cornerRadius = 6
        imageViewPlaceholder.layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
        imageViewPlaceholder.layer.shadowOffset = CGSize.zero
        imageViewPlaceholder.layer.shadowOpacity = 1
        imageViewPlaceholder.layer.shadowRadius = 3
        imageViewPlaceholder.layer.masksToBounds = false
        imageViewPlaceholder.backgroundColor = UIColor.white
        
        imageViewBackdrop.layer.cornerRadius = 6
        imageViewBackdrop.layer.masksToBounds = true
        imageViewBackdrop.contentMode = .scaleAspectFill
    }
}
