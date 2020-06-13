//
//  MovieCollectionViewCell.swift
//  MovieFlixApp
//
//  Created by Heena Mujawar on 12/06/20.
//  Copyright © 2020 Heena Mujawar. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

protocol MovieCollectionViewCellDelegate: class {
    func deleteItem(cell: MovieCollectionViewCell)
    func showIndicator(cell: MovieCollectionViewCell)
    func removeIndicator()
}

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    weak var delegate: MovieCollectionViewCellDelegate?

    var movie:Results? = nil {
        didSet {
            lblTitle.text = movie?.original_title ?? ""
            lblDescription.text = movie?.overview ?? ""
            let path = movie?.poster_path ?? ""
            let imgStr = "\(UrlStr.backdropUrl.rawValue)\(path)"
            if self.activityIndicator.isHidden{
                self.activityIndicator.isHidden = false
            }
            self.activityIndicator.startAnimating()
            DispatchQueue.main.async {
                self.imgPoster.af_setImage( withURL: URL(string: imgStr)!, placeholderImage: UIImage(named: "no image"), filter: nil, imageTransition: .crossDissolve(0.2), completion : { response in
                    DispatchQueue.main.async {
                        self.activityIndicator.isHidden = true
                        self.activityIndicator.stopAnimating()
                    }
                })
            }
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.delegate = nil
    }
    
    @IBAction func actionDeleteMovie(_ sender: Any) {
        self.delegate?.deleteItem(cell: self)
    }
    
}

