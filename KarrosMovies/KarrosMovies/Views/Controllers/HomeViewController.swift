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
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.backgroundColor = UIColor.white
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 1))
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.separatorStyle = .none
        
        self.refresh.tintColor = UIColor(red: 0, green: 203.0/255.0, blue: 207.0/255.0, alpha: 1)
        self.refresh.addTarget(self, action: #selector(self.didReloadData), for: .valueChanged)
        self.tableView.addSubview(refresh)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
        // 1 for section header
        // 1 for collection view cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let type = self.viewModel.sections[indexPath.section]
        
        let identifier = (indexPath.row == 0)
            ? "sectionHeader"
            : self.getCellIdentifier(type: type)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        if indexPath.row == 0 {
            self.configureSectionHeader(cell: cell, type: type)
        } else if let moviesCell = cell as? MoviesTableViewCell {
            self.configureMoviesCell(cell: moviesCell, type: type)
        }
        
        return cell ?? UITableViewCell(style: .default, reuseIdentifier: "cemptyCell")
    }
    
    private func getCellIdentifier(type: MovieSectionType) -> String {
        var identifier = "cell"
        switch type {
        case .recomandation:
            identifier = "cellRecommend"
            break
        case .category:
            identifier = "cellRecommend"
            break
        default:
            identifier = "cellMovies"
            break
        }
        
        return identifier
    }
    
    
    private func configureSectionHeader(cell: UITableViewCell?, type: MovieSectionType) {
        guard let header = cell as? SectionHeaderTableViewCell else {
            return
        }
        header.movieType = type
    }
    
    private func configureMoviesCell(cell: MoviesTableViewCell, type: MovieSectionType) {
        var subViewModel: MovieListViewModel?
        switch type {
        case .upcoming:
            subViewModel = self.viewModel.upcoming
            break
            
        case .topRated:
            subViewModel = self.viewModel.toprated
            break
            
        case .popular:
            subViewModel = self.viewModel.popular
            break
            
        default:
            break
        }
        
        
        cell.movies = subViewModel?.movies ?? []
        cell.handleLoadMore = {
            subViewModel?.getMoreData()
        }
    }
    
}

