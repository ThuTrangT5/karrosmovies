//
//  HomeViewModel.swift
//  KarrosMovies
//
//  Created by ThuTrangT5 on 4/19/20.
//  Copyright © 2020 ThuTrangT5. All rights reserved.
//

import UIKit

class HomeViewModel: BaseViewModel {
    
    var sections:[MovieListSectionType] = []
    let recommendation = MovieListViewModel(type: .recommendation)
    let popular = MovieListViewModel(type: .popular)
    let toprated = MovieListViewModel(type: .topRated)
    let upcoming = MovieListViewModel(type: .upcoming)
    
    override init() {
        super.init()
        
        self.sections = [
            .recommendation,
            .category,
            .popular,
            .topRated,
            .upcoming
        ]
        
        self.popular.isLoading
            .bind(to: self.isLoading)
            .disposed(by: disposeBag)
        
        self.toprated.isLoading
            .bind(to: self.isLoading)
            .disposed(by: disposeBag)
        
        self.upcoming.isLoading
            .bind(to: self.isLoading)
            .disposed(by: disposeBag)
        
        self.recommendation.isLoading
            .bind(to: self.isLoading)
            .disposed(by: disposeBag)
        
        self.popular.isUpdated
            .bind(to: self.isUpdated)
            .disposed(by: disposeBag)
        
        self.toprated.isUpdated
            .bind(to: self.isUpdated)
            .disposed(by: disposeBag)
        
        self.upcoming.isUpdated
            .bind(to: self.isUpdated)
            .disposed(by: disposeBag)
        
        self.recommendation.isUpdated
            .bind(to: self.isUpdated)
            .disposed(by: disposeBag)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData() {
        self.popular.reloadData()
        self.toprated.reloadData()
        self.upcoming.reloadData()
    }
    
    //    func get
    
}
