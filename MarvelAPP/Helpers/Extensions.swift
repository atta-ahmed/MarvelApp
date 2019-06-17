//
//  Extensions.swift
//  MarvelAPP
//
//  Created by Atta Amed on 6/12/19.
//  Copyright © 2019 Atta Amed. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    
    func downloadImageByKF(imagePath: String?){
        if let path = imagePath {
            self.kf.setImage(with:  URL(string: path ) , placeholder: UIImage(named: "placholder"), options: [], progressBlock: nil, completionHandler: nil)
        }
    }
    
    
    func downloadImageFrom(link:String, contentMode: UIView.ContentMode) {
        if let url = URL(string:link) {
            URLSession.shared.downloadTask(with: url ) { (data, responce, error) in
                
                DispatchQueue.main.async {
                    self.contentMode =  contentMode
                    let data = try? Data(contentsOf: data!)
                    if let imageData = data {
                        self.image = UIImage(data: imageData)
                    }
                }
                }.resume()
        }
    }
    
}

extension UIViewController {
    
    func makeNavigationTransparent() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func resetNavigationTransparency() {
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
    }
    
    func showFaileuirAlert(error: String){
        let alert = UIAlertController(title: nil , message:  error , preferredStyle: .alert)
        let alertOKAction = UIAlertAction(title: "Ok" , style: .default, handler: nil)
        alert.addAction(alertOKAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func alert(message: String){
        let alertView = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "Ok" , style: .default) { (action) in
            // pop here
        }
        alertView.addAction(OKAction)
        present(alertView, animated: true, completion: nil)
    }
    
    // Loading Indicator Factory
    func newLoadingIndicator() -> UIView {
        // Box Configuration
        let box = UIView(frame: CGRect(x: self.view.frame.width/2.0 - 30,
                                       y: self.view.frame.height/2.0 - 30,
                                       width: 60,
                                       height: 60))
        box.backgroundColor = UIColor(white: 0.0, alpha: 0.2)
        box.alpha = 1.0
        box.layer.cornerRadius = 10
        
        // Spinner configuration
        let activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        activityView.frame = CGRect(x: 10, y: 10, width: 40, height: 40)
        activityView.startAnimating()
        
        // Add the spinner to the box:
        box.addSubview(activityView)
        return box
    }
    
    func showLoadingIndicator(_ indicator: UIView) {
        self.view.addSubview(indicator)
        self.view.isUserInteractionEnabled = false
    }
    
    func hideLoadingIndicator(_ indicator: UIView) {
        indicator.removeFromSuperview()
        self.view.isUserInteractionEnabled = true
    }

}

