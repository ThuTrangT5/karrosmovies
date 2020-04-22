//
//  MovieDetailSectionType.swift
//  KarrosMovies
//
//  Created by ThuTrangT5 on 4/22/20.
//  Copyright © 2020 ThuTrangT5. All rights reserved.
//

import UIKit

enum MovieDetailSectionType: String {
    case overview = "Overview"
    case yourRate = "Your Rate"
    case cast = "Series Cast"
    case video = "Video"
    case comments = "Comments"
    case recommendations = "Recomendations"
    
    func showTitle() -> Bool {
        if self == .overview {
            return false
        }
        
        return true
    }
    
    func showArrow() -> Bool {
        if self == .comments || self == .recommendations {
            return true
        }
        
        return false
    }
}
