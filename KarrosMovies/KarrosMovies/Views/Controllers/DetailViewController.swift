//
//  DetailViewController.swift
//  KarrosMovies
//
//  Created by ThuTrangT5 on 4/21/20.
//  Copyright © 2020 ThuTrangT5. All rights reserved.
//

import UIKit
import Kingfisher
import RxSwift

class DetailViewController: BaseViewController {
    
    @IBOutlet weak var imageViewBackdrop: UIImageView!
    @IBOutlet weak var imageViewPoster: UIImageView!
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var buttonPlay: UIButton!
    @IBOutlet weak var labelRate: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    let refresh = UIRefreshControl()
    
    var viewModel = DetailViewModel()
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
        
        buttonBack.layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
        buttonBack.layer.shadowOffset = CGSize.zero
        buttonBack.layer.shadowOpacity = 1
        buttonBack.layer.shadowRadius = 3
        
        imageViewPoster.layer.cornerRadius = 6
        imageViewPoster.layer.masksToBounds = true
        imageViewPoster.contentMode = UIView.ContentMode.scaleAspectFill
        
        self.setupTableView()
        self.setupCollectionView()
    }
    
    func setupCollectionView() {
        self.collectionView.backgroundColor = UIColor.clear
        self.collectionView.layer.masksToBounds = false
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.isScrollEnabled = true
        self.collectionView.layer.masksToBounds = true
        
        if let flow = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flow.minimumLineSpacing = 5
            flow.minimumInteritemSpacing = 5
            flow.scrollDirection = .vertical
        }
    }
    
    func bindTopView(movie: MovieModel) {
        self.imageViewBackdrop.kf.setImage(with: movie.backdropURL)
        self.imageViewPoster.kf.setImage(with: movie.imageURL)
        self.buttonPlay.isHidden = !movie.hasVideo
        self.labelDate.text = movie.releaseDateString
    }
    
    func setupRx() {
        self.bindingBaseRx(withViewModel: self.viewModel)
        
        self.viewModel.movieInfo
            .subscribe(onNext: { [weak self](model) in
                if let movie = model {
                    self?.bindTopView(movie: movie)
                    self?.tableView.reloadData()
                }
            })
            .disposed(by: disposeBag)
        
        self.viewModel.genres
            .bind(to: collectionView.rx.items) { (collectionView, row, element) in
                let indexPath = IndexPath(row: row, section: 0)
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellGenre", for: indexPath)
                if let genreCell = cell as? GenreCollectionViewCell {
                    genreCell.bindData(genre: element)
                }
                return cell
        }
        .disposed(by: disposeBag)
        
        self.viewModel.isUpdated
            .subscribe(onNext: { [weak self](updated) in
                if updated {
                    self?.tableView.reloadData()
                }
            })
            .disposed(by: disposeBag)
    }
    
    // MARK:- Actions
    
    @IBAction func ontouchBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func ontouchPlay(_ sender: Any) {
    }
}


extension DetailViewController {
    class func openDetail(movieID: NSNumber, fromContext context: UIViewController) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            vc.movieID = movieID
            
            if let nav = context.navigationController {
                nav.pushViewController(vc, animated: true)
            } else {
                context.present(vc, animated: true, completion: nil)
            }
        }
    }
}
