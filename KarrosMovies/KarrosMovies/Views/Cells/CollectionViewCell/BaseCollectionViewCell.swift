//
//  BaseCollectionViewCell.swift
//  KarrosMovies
//
//  Created by ThuTrangT5 on 4/22/20.
//  Copyright © 2020 ThuTrangT5. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    class func cellIdentifier() -> String {
        return "\(self.classForCoder())"
    }
    
    class func registerCellToTableView(collectionView: UICollectionView) {
        let identifier = cellIdentifier()
        let bundle = Bundle(for: self.classForCoder())
        let  nib = UINib(nibName: identifier, bundle: bundle)
        collectionView.register(nib, forCellWithReuseIdentifier: identifier)
    }
}
