//
//  MAResponce.swift
//  MarvelAPP
//
//  Created by Atta Amed on 6/11/19.
//  Copyright © 2019 Atta Amed. All rights reserved.
//

import Foundation

import SwiftyJSON

protocol JSONModel {
    init?(parameter: JSON)
}

struct CharListResponce: JSONModel {
    
    var data: CharResponce?
    
     init?(parameter: JSON) {
        data = CharResponce(parameter: parameter["data"])
    }
    
}
