//
//  SectionHeaderTableViewCell.swift
//  KarrosMovies
//
//  Created by ThuTrangT5 on 4/18/20.
//  Copyright © 2020 ThuTrangT5. All rights reserved.
//

import UIKit

class SectionHeaderTableViewCell: BaseTableViewCell {
    
    @IBOutlet weak var labelSection: UILabel!
    @IBOutlet weak var imageViewArrow: UIImageView!
    
    
    func bindData(sectionName: String?, showArrow: Bool = true) {
        self.labelSection.text = sectionName
        self.imageViewArrow.isHidden = !showArrow
    }
}
