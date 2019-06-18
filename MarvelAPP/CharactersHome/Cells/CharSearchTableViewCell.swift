//
//  CharSearchTableViewCell.swift
//  MarvelAPP
//
//  Created by Atta Amed on 6/13/19.
//  Copyright © 2019 Atta Amed. All rights reserved.
//

import UIKit

class CharSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var charImage: UIImageView!
    @IBOutlet weak var charNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

 
    func configCell(character: Character){
        let imageFullPath = character.thumImage?.fullPath()
        charImage.downloadImageByKF(imagePath: imageFullPath)
        charImage.contentMode = .scaleAspectFill
        // charImag.downloadImageFrom(link: imageFullPath ?? "", contentMode: .scaleAspectFill)
        charNameLabel.text = character.name
        
    }
}
