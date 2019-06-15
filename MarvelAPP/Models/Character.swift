//
//  Character.swift
//  MarvelAPP
//
//  Created by Atta Amed on 6/11/19.
//  Copyright © 2019 Atta Amed. All rights reserved.
//

import Foundation
import SwiftyJSON

struct CharResponce: JSONModel {
    
    var count: Int?
    var limit: Int?
    var offset: Int?
    var charList: [Character] = []
    
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


struct Character: JSONModel {
    
    var id: Int?
    var name: String?
    var description: String?
    var thumImage: ThumbImage?
    var title: String?
    
    init(parameter: JSON) {
        id = parameter["id"].intValue
        name = parameter["name"].stringValue
        description = parameter["description"].stringValue
        title = parameter["title"].stringValue
        thumImage = ThumbImage(parameter: parameter["thumbnail"])
    }
    
}

struct ThumbImage: JSONModel {
    
    var path: String = ""
    var imageExtension: String = ""
    
    func fullPath() -> String {
        return "\(path).\(imageExtension)"
    }
    
    init(parameter: JSON) {
        path = parameter["path"].stringValue
        imageExtension = parameter["extension"].stringValue
    }
    
}

struct CharDetaial: JSONModel{
    
    var available: Int?
    var collectionURI: String?
    var items: [Item] = []
    var returned: Int?
    
    init(parameter: JSON) {
        available = parameter["available"].intValue
        collectionURI = parameter["collectionURI"].stringValue
        returned = parameter["returned"].intValue
        
        if let jasonArray = parameter["items"].array {
            for json in jasonArray {
                items.append(Item(parameter: json))
            }
        }
        
    }
}

struct Item: JSONModel{
    var name: String?
    var resourceURI: String?
    
    init(parameter: JSON) {
        name = parameter["name"].stringValue
        resourceURI = parameter["resourceURI"].stringValue
        
    }
    
}
