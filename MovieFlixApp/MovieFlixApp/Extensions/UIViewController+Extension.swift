//
//  UIViewController.swift
//  MovieFlixApp
//
//  Created by Heena Mujawar on 12/06/20.
//  Copyright © 2020 Heena Mujawar. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    func showSpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .large)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }

        return spinnerView
    }
    
    func removeSpinner(vSpinner:UIView) {
        DispatchQueue.main.async {
            vSpinner.removeFromSuperview()
        }
    }
    
    func showError(message: String, title: String = "") {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okButton)
        self.dismiss(animated: true){ () -> Void in
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

