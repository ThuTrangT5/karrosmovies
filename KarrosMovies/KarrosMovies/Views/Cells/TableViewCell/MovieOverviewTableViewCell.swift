//
//  MovieOverviewTableViewCell.swift
//  KarrosMovies
//
//  Created by ThuTrangT5 on 4/21/20.
//  Copyright © 2020 ThuTrangT5. All rights reserved.
//

import UIKit

class MovieOverviewTableViewCell: UITableViewCell {
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelOverview: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindData(movie: MovieModel) {
        self.labelTitle.text = movie.title?.uppercased()
        self.labelOverview.text = movie.overview
        
    }
}
