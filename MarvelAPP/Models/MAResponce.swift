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

struct CharResponce: JSONModel {
    
    var count: Int?
    var limit: Int?
    var offset: Int?
    var charList: [Details] = []
    
    init(parameter: JSON) {
        count = parameter["count"].intValue
        limit = parameter["limit"].intValue
        offset = parameter["offset"].intValue
        if let jasonArray = parameter["results"].array {
            for json in jasonArray {
                charList.append(Character(parameter: json))
            }
        }
        
    }
    
}

struct CharListResponce: JSONModel {
    
    var data: CharResponce?
    
     init?(parameter: JSON) {
        data = CharResponce(parameter: parameter["data"])
    }
    
}
