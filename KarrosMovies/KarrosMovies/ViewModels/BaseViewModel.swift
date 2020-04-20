//
//  BaseViewModel.swift
//  KarrosMovies
//
//  Created by ThuTrangT5 on 4/18/20.
//  Copyright © 2020 ThuTrangT5. All rights reserved.
//

import RxSwift

class BaseViewModel: NSObject {
    
    public var isLoading: BehaviorSubject<Bool> = BehaviorSubject<Bool>(value: false)
    public var error: BehaviorSubject<Error?> = BehaviorSubject<Error?>(value: nil)
    public let disposeBag = DisposeBag()
    public var isUpdated: BehaviorSubject<Bool> = BehaviorSubject<Bool>(value: false)
    
    public override init() {
        super.init()
        
        self.setupBinding()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setupBinding() {
        
    }
}
