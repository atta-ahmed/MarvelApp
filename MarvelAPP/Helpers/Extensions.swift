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
            // Processor for resizing images

            self.kf.setImage(with: URL(string: path ),
                             placeholder: nil,
                             options: nil,
                             progressBlock: nil,
                             completionHandler: nil )
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
