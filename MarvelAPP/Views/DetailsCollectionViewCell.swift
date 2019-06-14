//
//  DetailsCollectionViewCell.swift
//  MarvelAPP
//
//  Created by Atta Amed on 6/14/19.
//  Copyright © 2019 Atta Amed. All rights reserved.
//

import UIKit

class DetailsCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var Namelabel: UILabel!
    
    func configCollectionDetail( obj: Item){
        Namelabel.text = obj.name
        image.downloadImageByKF(imagePath: obj.resourceURI)
    }
    
}
