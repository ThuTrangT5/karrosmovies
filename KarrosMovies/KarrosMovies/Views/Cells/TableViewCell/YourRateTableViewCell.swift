//
//  YourRateTableViewCell.swift
//  KarrosMovies
//
//  Created by ThuTrangT5 on 4/22/20.
//  Copyright © 2020 ThuTrangT5. All rights reserved.
//

import UIKit

class YourRateTableViewCell: BaseTableViewCell {

    @IBOutlet weak var buttonWriteComment: UIButton!
    @IBOutlet weak var labelRate: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.buttonWriteComment.layer.cornerRadius = 6
        self.buttonWriteComment.layer.masksToBounds = true
        
        for tag in 10...14 {
            if let imageView = self.contentView.viewWithTag(tag) as? UIImageView {
                imageView.image = UIImage(named: "ic_star_empty")
            }
        }
        
        self.labelRate.text = "0.0"
    }
    
    func bindData(comment: String?, rate: Double?) {
        
    }

    
}
