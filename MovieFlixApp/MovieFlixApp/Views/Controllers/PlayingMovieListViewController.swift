//
//  PlayingMovieListViewController.swift
//  MovieFlixApp
//
//  Created by Heena Mujawar on 12/06/20.
//  Copyright © 2020 Heena Mujawar. All rights reserved.
//

import UIKit

class PlayingMovieListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var filtered:[Results] = []
    var searchActive : Bool = false
    let viewModel = MovieDataViewModel(manager: NetworkManager())
    var dataSource = [Results]()
    var refreshControl = UIRefreshControl()
    var spinnerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.attemptFetchMovie(endPoint: "now_playing")
        searchBar.accessibilityTraits = UIAccessibilityTraits.searchField
        self.setUpRefreshControl()
    }
    
    func setUpRefreshControl(){
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.tintColor = .red
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        collectionView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        self.collectionView.reloadData()
        refreshControl.endRefreshing()
    }

    // MARK: - Networking
    private func attemptFetchMovie(endPoint: String) {
        self.viewModel.isLoading = true
        viewModel.fetchPlayingMovie(endPoint: endPoint)
      
        
        viewModel.updateLoadingStatus = {
            let _ = self.viewModel.isLoading ? self.spinnerView = self.showSpinner(onView: self.view) : self.removeSpinner(vSpinner: self.spinnerView)
        }
        
        viewModel.showAlertClosure = {
            if let error = self.viewModel.error {
                self.showError(message: error.localizedDescription)
            }
        }
        
        viewModel.didFinishFetch = {
            self.viewModel.isLoading = false
            guard let data = self.viewModel.movieData else{ return }
            self.dataSource = data
            self.collectionView.reloadData()
        }
    }
}

