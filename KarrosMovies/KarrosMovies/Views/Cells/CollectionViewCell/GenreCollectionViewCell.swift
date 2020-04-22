//
//  GenreCollectionViewCell.swift
//  KarrosMovies
//
//  Created by ThuTrangT5 on 4/22/20.
//  Copyright © 2020 ThuTrangT5. All rights reserved.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var labelName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if let cover = labelName.superview {
            cover.layer.cornerRadius = 5
            cover.layer.masksToBounds = true
        }
    }
    
    func bindData(genre: GenreModel) {
        labelName.text = genre.name
    }
}
