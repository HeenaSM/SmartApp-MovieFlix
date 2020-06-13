//
//  MovieDataViewModel.swift
//  MovieFlixApp
//
//  Created by Heena Mujawar on 12/06/20.
//  Copyright © 2020 Heena Mujawar. All rights reserved.
//

import Foundation

class MovieDataViewModel {
        
    // MARK: - Properties
    private var movie: MovieData? {
        didSet {
            guard let m = movie else { return }
            self.setupData(with: m)
            self.didFinishFetch?()
        }
    }
    
    var error: Error? {
         didSet { self.showAlertClosure?() }
     }
     var isLoading: Bool = false {
         didSet { self.updateLoadingStatus?() }
     }
    
    var movieData:[Results]?
    var filtered:[Results]?
    private var manager: NetworkManager?
    
    // MARK: - Closures for callback, since we are not using the ViewModel to the View.
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (() -> ())?
    
    // MARK: - Constructor
    init(manager: NetworkManager) {
        self.manager = manager
    }
    
    func fetchPlayingMovie(endPoint: String) {
        if Connectivity.isConnectedToInternet() == true{
            self.manager?.fetchNowPlayingMovie(with: endPoint, completion: { (movie, error) in
                   if let error = error {
                       self.error = error
                       self.isLoading = false
                       return
                   }
                   self.error = nil
                   self.isLoading = false
                   self.movie = movie
               })
        }else{
            self.showAlertClosure?()
        }
    }
    
    func fetchTopRatedMovie(endPoint: String) {
        if Connectivity.isConnectedToInternet() == true{
            self.manager?.fetchTopRatedMovie(with: endPoint, completion: { (movie, error) in
                if let error = error {
                    self.error = error
                    self.isLoading = false
                    return
                }
                self.error = nil
                self.isLoading = false
                self.movie = movie
            })
        }else{
            self.showAlertClosure?()
        }
    }
    
    private func setupData(with movie: MovieData) {
        
        guard let result = movie.results else{ return }
        self.movieData = result
    }
    
    func getSearchResult(searchText:String){
        filtered = self.movieData!.filter({ (item) -> Bool in
            let movieName:String = item.original_title!
            
            let nsRange = NSString(string: movieName).range(of: searchText, options: String.CompareOptions.caseInsensitive)
            
            return nsRange.location != NSNotFound
        })
    }
}
