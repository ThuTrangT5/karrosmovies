//
//  MovieModel.swift
//  KarrosMovies
//
//  Created by ThuTrangT5 on 4/19/20.
//  Copyright © 2020 ThuTrangT5. All rights reserved.
//

import SwiftyJSON

class MovieModel: BaseModel {

    var movieID: NSNumber?
    var title: String?
    var imageURL: URL?
    var averageRated: Double = 0
    var overview: String?
//    var casts: []
    var videos: [String] = []
//    var coments: []
//    var myRated:
    
    required init(json: JSON) {
        super.init()
        
        movieID = json["id"].number
        title = json["title"].string
        if let poster = json["poster_path"].string {
            let fullLink = APIManager.imageBaseURL + poster
            imageURL = URL(string: fullLink)
        }
        
        averageRated = json["vote_average"].doubleValue
        overview = json["overview"].string
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
