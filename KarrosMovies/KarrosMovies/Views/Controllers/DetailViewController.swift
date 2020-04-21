//
//  DetailViewController.swift
//  KarrosMovies
//
//  Created by ThuTrangT5 on 4/21/20.
//  Copyright © 2020 ThuTrangT5. All rights reserved.
//

import UIKit
import Kingfisher

class DetailViewController: BaseViewController {
    
    @IBOutlet weak var imageViewBackdrop: UIImageView!
    @IBOutlet weak var imageViewPoster: UIImageView!
    @IBOutlet weak var buttonPlay: UIButton!
    @IBOutlet weak var labelRate: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    
    @IBOutlet weak var collectionViewGenres: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    let refresh = UIRefreshControl()
    
    private var viewModel = DetailViewModel()
    var movieID: NSNumber?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.setupUI()
        self.setupRx()
        self.viewModel.movieID.onNext(self.movieID)
        
    }
    
    func setupUI() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        imageViewPoster.layer.cornerRadius = 6
        imageViewPoster.layer.masksToBounds = true
        imageViewPoster.contentMode = UIView.ContentMode.scaleAspectFill
        
        self.setupTableView()
    }
    
    func bindTopView(movie: MovieModel) {
        self.imageViewBackdrop.kf.setImage(with: movie.backdropURL)
        self.imageViewPoster.kf.setImage(with: movie.imageURL)
        self.buttonPlay.isHidden = !movie.hasVideo
        self.labelDate.text = movie.releaseDateString
        
    }
    
    func setupRx() {
        self.viewModel.movieInfo
            .subscribe(onNext: { (model) in
                if let movie = model {
                    self.bindTopView(movie: movie)
                    //                    self.ta
                }
            })
            .disposed(by: disposeBag)
    }
    
    // MARK:- Actions
    
    @IBAction func ontouchBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var ontouchPlay: NSLayoutConstraint!
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

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
        
    }
    
    @objc func didReloadData() {
        guard let movieID = self.movieID else {
            return
        }
        self.viewModel.getData(movieID: movieID)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        return cell ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
    }
}
