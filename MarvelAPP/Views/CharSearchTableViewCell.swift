//
//  CharSearchTableViewCell.swift
//  MarvelAPP
//
//  Created by Atta Amed on 6/13/19.
//  Copyright © 2019 Atta Amed. All rights reserved.
//

import UIKit

class CharSearchTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var charImage: UIImageView!
    @IBOutlet weak var charNameLabel: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
