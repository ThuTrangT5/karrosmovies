//
//  HomeViewController2.swift
//  KarrosMovies
//
//  Created by ThuTrangT5 on 4/22/20.
//  Copyright © 2020 ThuTrangT5. All rights reserved.
//

import UIKit

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
        
        SectionHeaderTableViewCell.registerCellToTableView(tableView: self.tableView)
        RecommendationsTableViewCell.registerCellToTableView(tableView: self.tableView)
        MoviesTableViewCell.registerCellToTableView(tableView: self.tableView)
        
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
            ? SectionHeaderTableViewCell.cellIdentifier()
            : self.getCellIdentifier(type: type)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        if indexPath.row == 0 {
            self.configureSectionHeader(cell: cell, type: type)
            
//        } else if let recommendation = cell as? RecommendationsTableViewCell {
//            recommendation.movies = self.viewModel.recommendation.movies
//            recommendation.handleLoadMore = {
//                self.viewModel.recommendation.getMoreData()
//            }
//            recommendation.handleDidSelectMovie = { [weak self](movieID) in
//                self?.openDetailScreen(movieID: movieID)
//            }
            
        } else if let moviesCell = cell as? MoviesTableViewCell {
            self.configureMoviesCell(cell: moviesCell, type: type)
        }
        
        return cell ?? UITableViewCell(style: .default, reuseIdentifier: "cemptyCell")
    }
    
    private func getCellIdentifier(type: MovieListSectionType) -> String {
        var identifier = "cell"
        switch type {
        case .recommendation:
            identifier = RecommendationsTableViewCell.cellIdentifier()
            break
        case .category:
            identifier = "cellRecommend"
            break
        default:
            identifier = MoviesTableViewCell.cellIdentifier()
            break
        }
        
        return identifier
    }
    
    
    private func configureSectionHeader(cell: UITableViewCell?, type: MovieListSectionType) {
        guard let header = cell as? SectionHeaderTableViewCell else {
            return
        }
        header.bindData(sectionName: type.rawValue)
    }
    
    private func configureMoviesCell(cell: MoviesTableViewCell, type: MovieListSectionType) {
        var subViewModel: MovieListViewModel?
        switch type {
        case .recommendation:
            subViewModel = self.viewModel.recommendation
            break
            
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
        cell.handleDidSelectMovie = { [weak self](movieID) in
            self?.openDetailScreen(movieID: movieID)
        }
    }
    
}
