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
    var genres: BehaviorSubject<[GenreModel]> = BehaviorSubject<[GenreModel]>(value: [])
    var recommendations: BehaviorSubject<[MovieModel]> = BehaviorSubject<[MovieModel]>(value: [])
    var detailItems: [MovieDetailSectionType] = []
    
    override init() {
        super.init()
        
        self.movieID
            .subscribe(onNext: { [weak self](id) in
                if let id = id {
                    self?.getData(movieID: id)
                    self?.getRecommendations(movieID: id)
                }
            })
            .disposed(by: disposeBag)
       
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateDetailItems(movie: MovieModel?) {
        guard let movie = movie else {
            self.detailItems.removeAll()
            return
        }
        self.detailItems = [
            .overview,
            .yourRate,
//            .cast,
//            .video,
//            .comments,
            .recommendations
        ]
    }
    
    func getData(movieID: NSNumber) {
        
        self.isLoading.onNext(true)
        APIManager.shared.getMovieDetail(movieID: movieID) { [weak self](model, error) in
            self?.isLoading.onNext(false)
            
            if let error = error {
                self?.error.onNext(error)
            } else {
                
                self?.updateDetailItems(movie: model)
                self?.movieInfo.onNext(model)
                self?.genres.onNext(model?.genres ?? [])
                self?.isUpdated.onNext(true)
            }
        }
    }
    
    func getRecommendations(movieID: NSNumber) {
        self.isLoading.onNext(true)
        APIManager.shared.getMovieRecommendations(movieID: movieID) { [weak self](recommendations, error) in
            self?.isLoading.onNext(false)
            
            if let error = error {
                self?.error.onNext(error)
            } else {
                if recommendations.isEmpty,
                    let index = self?.detailItems.firstIndex(of: .recommendations){
                    self?.detailItems.remove(at: index)
                }
                self?.recommendations.onNext(recommendations)
                self?.isUpdated.onNext(true)
            }
        }
    }
    
    func getTotalRecomendation() -> Int {
        guard let array = try? self.recommendations.value() else { return 0 }
        
        return array.count
    }
    
    func getMovie() -> MovieModel? {
        guard let movie = try? self.movieInfo.value() else {
            return nil
        }
        
        return movie
    }
}
