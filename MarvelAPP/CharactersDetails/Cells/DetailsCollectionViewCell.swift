//
//  DetailsCollectionViewCell.swift
//  MarvelAPP
//
//  Created by Atta Amed on 6/14/19.
//  Copyright © 2019 Atta Amed. All rights reserved.
//

import UIKit

class DetailsCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet private weak var image: UIImageView!
    @IBOutlet private weak var Namelabel: UILabel!
    
    func configCollectionDetail( obj: Details){
        
        let imagPath = obj.thumImage?.fullPath()
        image.downloadImageByKF(imagePath: imagPath)
        Namelabel.text = obj.title ?? ""
    }
    
}
