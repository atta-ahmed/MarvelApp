//
//  Character.swift
//  MarvelAPP
//
//  Created by Atta Amed on 6/11/19.
//  Copyright © 2019 Atta Amed. All rights reserved.
//

import Foundation
import SwiftyJSON



class Details: JSONModel {
    var id: Int?
    var name: String?
    var description: String?
    var thumImage: ThumbImage?
    var title: String?
    var links: [Link] = []
    
    required init(parameter: JSON) {
        id = parameter["id"].intValue
        name = parameter["name"].stringValue
        description = parameter["description"].stringValue
        title = parameter["title"].stringValue
        thumImage = ThumbImage(parameter: parameter["thumbnail"])
        
        if let jasonArray = parameter["urls"].array {
            for json in jasonArray {
                links.append(Link(parameter: json))
            }
        }
    }
}


class Character: Details {
    
    var charDetails: [ [String:[Details]] ] = []
    
    required init(parameter: JSON) {
        super.init(parameter: parameter)
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

struct Link: JSONModel {
    var type: String?
    var url: String?
    
    init(parameter: JSON) {
        type = parameter["type"].stringValue
        url = parameter["url"].stringValue
    }
    
}
