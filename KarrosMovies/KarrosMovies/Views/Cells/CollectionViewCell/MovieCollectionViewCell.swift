//
//  MovieCollectionViewCell.swift
//  KarrosMovies
//
//  Created by ThuTrangT5 on 4/18/20.
//  Copyright © 2020 ThuTrangT5. All rights reserved.
//

import UIKit
import Kingfisher

class MovieCollectionViewCell: BaseCollectionViewCell {
    @IBOutlet weak var imageViewPoster: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imageViewPlaceholder: UIImageView!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        imageViewPoster.layer.cornerRadius = 6
        imageViewPoster.layer.masksToBounds = true
        imageViewPoster.contentMode = UIView.ContentMode.scaleAspectFill
        
        imageViewPlaceholder.layer.cornerRadius = 6
        imageViewPlaceholder.layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
        imageViewPlaceholder.layer.shadowOffset = CGSize.zero
        imageViewPlaceholder.layer.shadowOpacity = 1
        imageViewPlaceholder.layer.shadowRadius = 3
        imageViewPlaceholder.layer.masksToBounds = false
        imageViewPlaceholder.backgroundColor = UIColor.white
    }
    
    var movie: MovieModel? {
        didSet {
            self.bindData()
        }
    }
    
    func bindData() {
        self.labelTitle.text = movie?.title
        
        self.imageViewPoster.kf.cancelDownloadTask()
        self.imageViewPoster.kf.setImage(with: movie?.imageURL)
    }
    
}
