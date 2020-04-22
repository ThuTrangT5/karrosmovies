//
//  MovieListViewModel.swift
//  KarrosMovies
//
//  Created by ThuTrangT5 on 4/21/20.
//  Copyright © 2020 ThuTrangT5. All rights reserved.
//

import RxSwift



class MovieListViewModel: BaseViewModel {
    
    var type: MovieListSectionType = .popular
    private var currentPage: Int = 1
    private var isLoadAll = false
    var movies: [MovieModel] = []
    
    
    init(type: MovieListSectionType) {
        super.init()
        self.type = type
        self.reloadData()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData() {
        self.currentPage = 1
        self.isLoadAll = false
        self.movies.removeAll()
        self.getData(page: 1)
    }
    
    func getMoreData() {
        guard self.isLoadAll == false else {
            print("load ALL data for \(type.rawValue)")
            return
        }
        
        self.getData(page: self.currentPage + 1)
    }
    
    
    func getData(page: Int) {
        self.isLoading.onNext(true)
        
        let handleResponseData = {[weak self](_ movies: [MovieModel], _ error: Error?)  in
            self?.isLoading.onNext(false)
            
            if let error = error {
                self?.error.onNext(error)
            } else {
                self?.currentPage = page
                if movies.isEmpty == false {
                    self?.movies.append(contentsOf: movies)
                    self?.isUpdated.onNext(true)
                } else {
                    self?.isLoadAll = true
                }
            }
        }
        
        switch type {
        case .recommendation:
            APIManager.shared.getRecommendations(page: page, callback: handleResponseData)
            break
            
        case .popular:
            APIManager.shared.getPopular(page: page, callback: handleResponseData)
            break
            
        case .topRated:
            APIManager.shared.getTopRate(page: page, callback: handleResponseData)
            break
            
        case .upcoming:
            APIManager.shared.getUpComing(page: page, callback: handleResponseData)
            break
            
        default:
            break
        }
    }
}
