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
    private let baseURL = "https://api.themoviedb.org/3/"
    static let imageBaseURL = "https://image.tmdb.org/t/p/w500"
    private var apiKey: String = ""
    
    //        private var sessionID: String = ""
    //
    private func getHeader(accessToken: String? = nil) -> HTTPHeaders {
        //            var token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwNzgxMTk0ODg1MGQ4NThhZGUwZGY0MDk1ZTBiN2E1OSIsInN1YiI6IjU5YWU1ZTY4OTI1MTQxMDc2NTA1M2M3MiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.TJ6Qo70J5MWNazNgXMlKADYGQuozr6ErYZlw_JqmWFU"
        //
        let headers: HTTPHeaders = [
            //                "Authorization": "bearer \(token)",
            "Content-Type":"application/json;charset=utf-8"
        ]
        
        return headers
    }
    //
    //
    //    func getRequestToken(callback: ((String?, Error?)->Void)?) {
    //        let url = "authentication/token/new"
    //
    //        self.sendRequest(method: .get, urlString: url) { (response, error) in
    //            if let token = response["request_token"].string,
    //                token.isEmpty == false {
    ////                self.sessionID = token
    //            }
    //        }
    //    }
    //
    //    func getSessionID(requestToken: String, callback: ((String?, Error?)->Void)?) {
    //        let url = "authentication/session/new"
    //
    //        self.sendRequest(method: .post, urlString: url) { (response, error) in
    //            if let token = response["request_token"].string,
    //                token.isEmpty == false {
    //                self.sessionID = token
    //            }
    //        }
    //    }
    
    private func getAPIKey() -> String {
        if self.apiKey.isEmpty == false {
            return self.apiKey
        }
        
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
            let nsDictionary = NSDictionary(contentsOfFile: path)
            if let value = nsDictionary?.value(forKey: "MOVIE_API_KEY") as? String {
                self.apiKey = value
                return value
            }
        }
        
        return ""
    }
    
    private func sendRequest(method: HTTPMethod, urlString: String , parameters: Parameters? = nil, callback:((JSON, Error?)-> Void)?) {
        
        let url = self.baseURL + urlString
        let headers = self.getHeader()
        var params = parameters ?? [:]
        
        params["api_key"] = self.getAPIKey()
        
        print("REQUEST: \(url)")
        
        Alamofire.request(url, method: method, parameters: params, headers: headers)
            .responseJSON { (response) in
                
                if response.result.isFailure {
                    callback?(JSON.null, response.error)
                    
                } else if let value = response.result.value {
                    let json = JSON(value)
                    
                    let success = json["success"].bool ?? true
                    let errorMessage = json["status_message"].stringValue
                    
                    if success == true {
                        callback?(json, nil)
                    } else {
                        let error =  NSError(domain: NSURLErrorDomain, code: 0, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                        callback?(JSON.null, error)
                    }
                    
                } else {
                    callback?(JSON.null, nil)
                }
        }
        
        
    }
    
    func getRecommendations(page: Int, callback: (([MovieModel], Error?)->Void)?) {
        let url = "movie/100/recommendations"
        let param: Parameters = [
            "page": page
        ]
        self.sendRequest(method: .get, urlString: url, parameters: param) { (response, error) in
            if let error = error {
                callback?([], error)
            } else {
                let result = response["results"]
                let movies: [MovieModel] = MovieModel.getArray(json: result)
                callback?(movies, nil)
            }
        }
    }
    
    func getCategory() {
        // sample: https://api.themoviedb.org/3/genre/movie/list?api_key=07811948850d858ade0df4095e0b7a59&language=en-US
        let url = ""
        
    }
    
    func getPopular(page: Int, callback: (([MovieModel], Error?)->Void)?) {
        
        // sample: https://api.themoviedb.org/3/movie/popular?api_key=07811948850d858ade0df4095e0b7a59&language=en-US&page=1
        let url = "movie/popular"
        let param: Parameters = [
            "page": page
        ]
        self.sendRequest(method: .get, urlString: url, parameters: param) { (response, error) in
            if let error = error {
                callback?([], error)
            } else {
                let result = response["results"]
                let movies: [MovieModel] = MovieModel.getArray(json: result)
                callback?(movies, nil)
            }
        }
    }
    
    func getTopRate(page: Int, callback: (([MovieModel], Error?)->Void)?) {
        // sample: https://api.themoviedb.org/3/movie/top_rated?api_key=07811948850d858ade0df4095e0b7a59&language=en-US&page=1
        let url = "movie/top_rated"
        let param: Parameters = [
            "page": page
        ]
        self.sendRequest(method: .get, urlString: url, parameters: param) { (response, error) in
            if let error = error {
                callback?([], error)
            } else {
                let result = response["results"]
                let movies: [MovieModel] = MovieModel.getArray(json: result)
                callback?(movies, nil)
            }
        }
    }
    
    func getUpComing(page: Int, callback: (([MovieModel], Error?)->Void)?) {
        // sample: https://api.themoviedb.org/3/movie/upcoming?api_key=07811948850d858ade0df4095e0b7a59&language=en-US&page=1
        let url = "movie/upcoming"
        let param: Parameters = [
            "page": page
        ]
        self.sendRequest(method: .get, urlString: url, parameters: param) { (response, error) in
            if let error = error {
                callback?([], error)
            } else {
                let result = response["results"]
                let movies: [MovieModel] = MovieModel.getArray(json: result)
                callback?(movies, nil)
            }
        }
    }
    
    func getMovieDetail(movieID: NSNumber, callback: ((MovieModel?, Error?)->Void)?) {
        // sample: https://api.themoviedb.org/3/movie/537061?api_key=07811948850d858ade0df4095e0b7a59&language=en-US
        let url = "movie/\(movieID)"
        self.sendRequest(method: .get, urlString: url) { (response, error) in
            if let error = error {
                callback?(nil, error)
            } else {
                let movie = MovieModel(json: response)
                callback?(movie, nil)
            }
        }
    }
    
    func getMovieRecommendations(movieID: NSNumber, callback: (([MovieModel], Error?)->Void)?) {
        // https://api.themoviedb.org/3/movie/537061/recommendations?api_key=07811948850d858ade0df4095e0b7a59&language=en-US&page=1
        let url = "movie/\(movieID)/recommendations"
        let param: Parameters = [
            "page": 1 // just get 1 page result for recommendation movies
        ]
        self.sendRequest(method: .get, urlString: url, parameters: param) { (response, error) in
            if let error = error {
                callback?([], error)
            } else {
                let result = response["results"]
                let movies: [MovieModel] = MovieModel.getArray(json: result)
                callback?(movies, nil)
            }
        }
    }
    
}
