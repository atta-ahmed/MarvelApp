//
//  MarvelMainTableViewCell.swift
//  MarvelAPP
//
//  Created by Atta Amed on 6/11/19.
//  Copyright © 2019 Atta Amed. All rights reserved.
//

import UIKit
import Kingfisher

class CharListTableViewCell: UITableViewCell {
   
    @IBOutlet weak var charImag: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configCell(character: Character){
        let imageFullPath = character.thumImage?.fullPath()
        charImag.downloadImageByKF(imagePath: imageFullPath)
        charImag.contentMode = .scaleAspectFill
        // charImag.downloadImageFrom(link: imageFullPath ?? "", contentMode: .scaleAspectFill)
        nameLabel.text = character.name
        charImag?.bringSubviewToFront(nameLabel.superview!)
        
    }

    
}
