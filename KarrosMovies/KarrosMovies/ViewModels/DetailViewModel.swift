//
//  DetailViewModel.swift
//  KarrosMovies
//
//  Created by ThuTrangT5 on 4/21/20.
//  Copyright © 2020 ThuTrangT5. All rights reserved.
//

import RxSwift

class DetailViewModel: BaseViewModel {
    
    var movieID: BehaviorSubject<NSNumber?> = BehaviorSubject<NSNumber?>(value: nil)
    var movieInfo: BehaviorSubject<MovieModel?> = BehaviorSubject<MovieModel?>(value: nil)
    
    override init() {
        super.init()
        
        self.movieID
            .subscribe(onNext: { (id) in
                if let id = id {
                    self.getData(movieID: id)
                }
            })
            .disposed(by: disposeBag)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getData(movieID: NSNumber) {
        
        self.isLoading.onNext(true)
        APIManager.shared.getMovieDetail(movieID: movieID) { [weak self](model, error) in
            self?.isLoading.onNext(false)
            
            if let error = error {
                self?.error.onNext(error)
            } else {
                self?.movieInfo.onNext(model)
            }
        }
    }
    
    
}
