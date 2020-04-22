//
//  HomeViewController.swift
//  KarrosMovies
//
//  Created by ThuTrangT5 on 4/17/20.
//  Copyright © 2020 ThuTrangT5. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: HomeViewModel = HomeViewModel()
    let refresh = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.setupUI()
        self.setupTableView()
        self.setupRx()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func setupUI() {
        let logo = UIImage(named: "top_logo")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        let user = UIImage(named: "ic_user")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        let leftButton = UIBarButtonItem(image: user, style: .done, target: self, action: #selector(self.ontouchUser))
        self.navigationItem.leftBarButtonItem = leftButton
        
        let search = UIImage(named: "ic_search")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        let rightButton = UIBarButtonItem(image: search, style: .done, target: self, action: #selector(self.ontouchSearch))
        self.navigationItem.rightBarButtonItem = rightButton
        
        // shadow navigation
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.3
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.withAlphaComponent(0.4).cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.navigationController?.navigationBar.layer.shadowRadius = 7
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func setupRx() {
        self.bindingBaseRx(withViewModel: self.viewModel)
        self.viewModel.isUpdated
            .subscribe(onNext: { [weak self](updated) in
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    // MARK:- Action
    
    @objc func ontouchUser() {
        
    }
    
    @objc func ontouchSearch() {
        
    }
    
    @objc func didReloadData() {
        self.refresh.endRefreshing()
        self.viewModel.reloadData()
    }
    
    func openDetailScreen(movieID: NSNumber) {
        DetailViewController.openDetail(movieID: movieID, fromContext: self)
    }
}
