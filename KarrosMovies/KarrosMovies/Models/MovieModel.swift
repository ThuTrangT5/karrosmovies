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
    var backdropURL: URL?
    var averageRated: Double = 0
    var overview: String?
    var hasVideo: Bool = false
    var releaseDate: Date?
    var releaseDateString: String?
    
    required init(json: JSON) {
        super.init()
        
        movieID = json["id"].number
        title = json["title"].string
        
        if let path = json["poster_path"].string, path.isEmpty == false {
            let fullLink = APIManager.imageBaseURL + path
            imageURL = URL(string: fullLink)
        }
        if let path = json["backdrop_path"].string, path.isEmpty == false {
            let fullLink = APIManager.imageBaseURL + path
            backdropURL = URL(string: fullLink)
        }
        
        if let text = json["release_date"].string, text.isEmpty == false {
            let formater = DateFormatter()
            formater.dateFormat = "yyyy-MM-dd"
            self.releaseDate = formater.date(from: text)
            
            if let date = releaseDate {
                formater.dateFormat = "MMMM dd"
                self.releaseDateString = formater.string(from: date)
            }
        }
        
        averageRated = json["vote_average"].doubleValue
        overview = json["overview"].string
        hasVideo = json["video"].boolValue
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
