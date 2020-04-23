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
    var imageURL: URL?
    
    required init(json: JSON) {
        super.init()
        
        genreID = json["id"].number
        name = json["name"].string
        if let path = json["path"].string {
            let fullLink = APIManager.imageBaseURL + path
            imageURL = URL(string: fullLink)
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
