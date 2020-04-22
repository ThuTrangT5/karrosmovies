//
//  DetailViewController+Gernes.swift
//  KarrosMovies
//
//  Created by ThuTrangT5 on 4/22/20.
//  Copyright © 2020 ThuTrangT5. All rights reserved.
//

import UIKit


extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
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
        MoviesTableViewCell.registerCellToTableView(tableView: self.tableView)
    }
    
    @objc func didReloadData() {
        guard let movieID = self.movieID else {
            return
        }
        
        self.viewModel.getData(movieID: movieID)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.detailItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let type = self.viewModel.detailItems[section]
        var rows = 1
        if type.showTitle() {
            rows += 1
        }
        
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = self.getCellIdentifier(indexPath: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        self.configureCell(cell: cell, atIndexPath: indexPath)
        
        return cell ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
    }
    
    private func getCellIdentifier(indexPath: IndexPath) -> String {
        let type = self.viewModel.detailItems[indexPath.section]
        var identifier = "cell"
        
        if indexPath.row == 0 && type.showTitle() {
            identifier = SectionHeaderTableViewCell.cellIdentifier()
            
        } else {
            switch type {
            case .overview:
                identifier = "cellOverView"
                break
            case .yourRate:
                identifier = "cellYourRate"
                break
            case .cast:
                identifier = "cellCast"
                break
            case .comments:
                identifier = "cellComment"
                break
            case .recommendations:
                identifier = MoviesTableViewCell.cellIdentifier()
                break
            default:
                break
            }
        }
        
        return identifier
    }
    
    private func configureCell(cell: UITableViewCell?, atIndexPath: IndexPath) {
        let type = self.viewModel.detailItems[atIndexPath.section]
        
        if let sectionHeader = cell as? SectionHeaderTableViewCell {
            sectionHeader.bindData(sectionName: type.rawValue, showArrow: type.showArrow())
            sectionHeader.backgroundColor = UIColor(red: 248.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: 1)
            
        } else if let overview = cell as? MovieOverviewTableViewCell,
            let movie = self.viewModel.getMovie() {
            overview.bindData(movie: movie)
            
        } else if let recommendation = cell as? MoviesTableViewCell {
            recommendation.movies = (try? self.viewModel.recommendations.value()) ?? []
            recommendation.handleDidSelectMovie = { [weak self] (movieID) in
                if let context = self {
                    DetailViewController.openDetail(movieID: movieID, fromContext: context)
                }
            }
        }
        
    }
}
