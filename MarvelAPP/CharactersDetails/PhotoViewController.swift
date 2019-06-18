//
//  PhotoViewController.swift
//  MarvelAPP
//
//  Created by Atta Amed on 6/18/19.
//  Copyright © 2019 Atta Amed. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var photoPath: String?
    var photoName: String?
    var photoIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        makeNavigationTransparent()
        
        if let path = photoPath {
            imageView.downloadImageByKF(imagePath: path)
            nameLable.text = photoName ?? ""
        }
        print("will appear")
    }
    override func viewWillDisappear(_ animated: Bool) {
        makeNavigationTransparent()
        print("disappear")
    }
    
   @IBAction func backToRoot(){
        self.dismiss(animated: true, completion: nil)
    }
}
