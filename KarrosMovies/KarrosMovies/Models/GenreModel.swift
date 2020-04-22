//
//  GenreModel.swift
//  KarrosMovies
//
//  Created by ThuTrangT5 on 4/22/20.
//  Copyright © 2020 ThuTrangT5. All rights reserved.
//

import SwiftyJSON

class GenreModel: BaseModel {
    var genreID: NSNumber?
    var name: String?
    
    
    required init(json: JSON) {
        super.init()
        
        genreID = json["id"].number
        name = json["name"].string
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
