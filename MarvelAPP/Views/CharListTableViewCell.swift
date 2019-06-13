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
        
        let processor = ResizingImageProcessor(referenceSize: CGSize(width: self.charImag.bounds.width * 2, height: 0), mode: .aspectFill)
        self.charImag?.kf.setImage(with: URL(string: imageFullPath! ),
                                    placeholder: nil,
                                    options: [.backgroundDecode,
                                              .transition(.fade(0.2)),
                                              .processor(processor)],
                                    progressBlock: nil,
                                    completionHandler: nil )
        
       // charImag.downloadImageFrom(link: imageFullPath ?? "", contentMode: .scaleAspectFill)
        charImag.contentMode = .scaleAspectFill
        
        nameLabel.text = character.name
        charImag?.bringSubviewToFront(nameLabel.superview!)
        
    }

    
}
