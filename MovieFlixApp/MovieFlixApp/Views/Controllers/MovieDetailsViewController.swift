//
//  MovieDetailsViewController.swift
//  MovieFlixApp
//
//  Created by Heena Mujawar on 12/06/20.
//  Copyright © 2020 Heena Mujawar. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var backPoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var lblOriginalTitle: UILabel!
    
    var movieModel: Results!
    var viewModel: MovieDataViewModel!
    var detailModel:MovieDetailViewModel!
    
    var spinnerView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
     
        self.detailModel = MovieDetailViewModel(movieModel: movieModel)
        self.loadImage()
        self.contentView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    }


    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func loadImage(){
        self.spinnerView = self.showSpinner(onView: self.view)
        DispatchQueue.main.async {
            self.backPoster.af_setImage(withURL: URL(string: self.detailModel.posterImage)!, placeholderImage: UIImage(named: "photo"), filter: nil, imageTransition: .crossDissolve(0.2), completion : { response in
                 DispatchQueue.main.async {
                    self.removeSpinner(vSpinner: self.spinnerView)
                }
            })
        }
        self.movieTitle.text = self.detailModel.movieTitle
        self.lblDate.text = self.detailModel.releaseData
        self.lblRating.text = self.detailModel.rating
        self.lblDuration.text = self.detailModel.duration
        self.lblDescription.text = self.detailModel.overView
        self.lblOriginalTitle.text = self.detailModel.movieTitle
    }
}
