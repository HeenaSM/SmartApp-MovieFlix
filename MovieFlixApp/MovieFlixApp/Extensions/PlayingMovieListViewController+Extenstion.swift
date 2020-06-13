//
//  PlayingMovieListViewController+Extenstion.swift
//  MovieFlixApp
//
//  Created by Heena Mujawar on 12/06/20.
//  Copyright © 2020 Heena Mujawar. All rights reserved.
//

import Foundation
import UIKit


extension PlayingMovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchActive{
            return self.filtered.count
        }else{
            return self.dataSource.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
         cell.delegate = self
         if searchActive{
            cell.movie = self.filtered[indexPath.row]
         }else{
            cell.movie = self.dataSource[indexPath.row]

        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(identifier: "MovieDetailsViewController") as! MovieDetailsViewController
        if searchActive{
            detailVC.movieModel = self.filtered[indexPath.row]
        }else{
            detailVC.movieModel = self.dataSource[indexPath.row]
        }
        detailVC.viewModel = self.viewModel
        self.present(detailVC, animated: true, completion: nil)
    }
}

extension PlayingMovieListViewController : UISearchBarDelegate{
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard self.searchBar.text != nil else { return }
        self.filtered = searchText.isEmpty ? dataSource : dataSource.filter { (item: Results) -> Bool in
            return item.original_title!.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        self.collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        searchBar.text = ""
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
        self.collectionView.reloadData()
        searchBar.resignFirstResponder()
    }
}

extension PlayingMovieListViewController: MovieCollectionViewCellDelegate{
    
    func showIndicator(cell: MovieCollectionViewCell) {
        DispatchQueue.main.async {
            self.spinnerView = self.showSpinner(onView: cell.imgPoster)
        }
    }
    
    func removeIndicator() {
        DispatchQueue.main.async {
             self.removeSpinner(vSpinner: self.spinnerView)
        }
    }
        
    func deleteItem(cell: MovieCollectionViewCell) {
        guard let indexPath = self.collectionView.indexPath(for: cell) else {
            return
        }
        if searchActive{
            self.filtered.remove(at: indexPath.row)
        }else{
           self.dataSource.remove(at: indexPath.row)
        }
        collectionView.performBatchUpdates({
            self.collectionView.deleteItems(at: [IndexPath(item: indexPath.row, section: 0)])
        }, completion: nil)
    }
}
