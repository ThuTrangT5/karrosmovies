//
//  HomeViewModel.swift
//  KarrosMovies
//
//  Created by ThuTrangT5 on 4/19/20.
//  Copyright © 2020 ThuTrangT5. All rights reserved.
//

import UIKit

class HomeViewModel: BaseViewModel {
    
     var sections:[MovieSectionType] = []
    
    
    override init() {
        super.init()
        
        self.sections = [
            .recomandation,
            .category,
            .popular,
            .topRated,
            .upcoming
            
        ]
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
