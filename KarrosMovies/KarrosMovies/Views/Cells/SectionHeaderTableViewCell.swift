//
//  SectionHeaderTableViewCell.swift
//  KarrosMovies
//
//  Created by ThuTrangT5 on 4/18/20.
//  Copyright © 2020 ThuTrangT5. All rights reserved.
//

import UIKit

class SectionHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelSection: UILabel!
    
    var movieType: MovieSectionType? {
        didSet {
            self.bindData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.selectionStyle = .none
    }
    
    func bindData() {
        self.labelSection.text = movieType?.rawValue.uppercased()
    }
    
}
