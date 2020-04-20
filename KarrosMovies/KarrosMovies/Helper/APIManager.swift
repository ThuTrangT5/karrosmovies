//
//  APIManager.swift
//  KarrosMovies
//
//  Created by ThuTrangT5 on 4/18/20.
//  Copyright © 2020 ThuTrangT5. All rights reserved.
//


import Alamofire
import SwiftyJSON

class APIManager: NSObject {
    
    static public var shared: APIManager = APIManager()
    private let apiKey = "api_key"
    private let baseURL = "https://api.themoviedb.org/4/list/1/"
    let imageBaseURL = "https://image.tmdb.org/t/p/"
    
    private func sendRequest(method: HTTPMethod, urlString: String , parameters: Parameters? = nil, callback:((JSON, Error?)-> Void)?) {
        
        let fullURL = self.baseURL
            + urlString
            + "?api_key=07811948850d858ade0df4095e0b7a59"
        
//        Alamofire.sen
        
    }
    
    func getRecomandation() {
        let url = "account/{account_id}/movie/recommendations"
    }
    
    func getPopular() {
        let url = "/account/{account_id}/movie/favorites"
    }
    
    func getTopRate() {
        let url = "/account/{account_id}/movie/rated"
    }
    
    func getUpComing() {
        let url = ""
    }
    
    func getMovieDetail(movieID: NSNumber) {
        let url = ""
    }
    
}
