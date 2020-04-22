//
//  BaseTableViewCell.swift
//  KarrosMovies
//
//  Created by ThuTrangT5 on 4/22/20.
//  Copyright © 2020 ThuTrangT5. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    class func cellIdentifier() -> String {
        return "\(self.classForCoder())"
    }
    
    class func registerCellToTableView(tableView: UITableView) {
        let identifier = cellIdentifier()
        let bundle = Bundle(for: self.classForCoder())
        let  nib = UINib(nibName: identifier, bundle: bundle)
        tableView.register(nib, forCellReuseIdentifier: identifier)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
