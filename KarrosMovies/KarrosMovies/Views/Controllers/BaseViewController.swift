//
//  BaseViewController.swift
//  KarrosMovies
//
//  Created by ThuTrangT5 on 4/18/20.
//  Copyright © 2020 ThuTrangT5. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MBProgressHUD

class BaseViewController: UIViewController {
    var disposeBag = DisposeBag()
    
    
    func handleError(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}


extension Reactive where Base: BaseViewController {
    
    /// Bindable sink for `startAnimating()`, `stopAnimating()` methods.
    var isAnimating: Binder<Bool> {
        return Binder(self.base, binding: { (vc, active) in
            if active {
                vc.startAnimating()
            } else {
                vc.stopAnimating()
            }
        })
    }
}

// MARK:- Handle Error

extension BaseViewController {
    
    func startAnimating(){
        if let activityLoader = self.view.viewWithTag(999) as? MBProgressHUD {
            activityLoader.show(animated: true)
            return
        }
        
        let activityLoader = MBProgressHUD.showAdded(to: self.view, animated: true)
        activityLoader.tag = 999
        
    }
    func stopAnimating() {
        if let activityLoader = self.view.viewWithTag(999) as? MBProgressHUD {
            activityLoader.hide(animated: true)
            activityLoader.removeFromSuperview()
        }
    }
    
    func bindingBaseRx(withViewModel viewModel: BaseViewModel) {
        // binding loading && error
        viewModel.isLoading
            .bind(to: self.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel.error
            .subscribe(onNext: { [weak self](error) in
                if let error = error {
                    self?.handleError(error: error)
                }
            })
            .disposed(by: disposeBag)
    }
}
