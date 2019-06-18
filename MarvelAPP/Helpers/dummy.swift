//
//  dummy.swift
//  MarvelAPP
//
//  Created by Atta Amed on 6/18/19.
//  Copyright © 2019 Atta Amed. All rights reserved.
//

// import Foundation
/*

import Foundation
import SwiftyJSON
import RealmSwift
import Realm



class RealmCharResponce: MAResponce {
    
    @objc dynamic var count: Int = 0
    @objc dynamic var limit: Int = 0
    @objc dynamic var offset: Int = 0
    @objc dynamic var charList: [RealmDetails] = []
    
    required init?(parameter: JSON) {
        count = parameter["count"].intValue
        limit = parameter["limit"].intValue
        offset = parameter["offset"].intValue
        if let jasonArray = parameter["results"].array {
            for json in jasonArray {
                charList.append(RealmCharacter(parameter: json)!)
            }
        }
        super.init(parameter: parameter)
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        fatalError("init(realm:schema:) has not been implemented")
    }
    
    required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
    
}

class RealmCharListResponce: MAResponce {
    
    @objc dynamic var data: RealmCharResponce?
    
    required init?(parameter: JSON) {
        data = RealmCharResponce(parameter: parameter["data"])
        super.init(parameter: parameter)
    }
    
    required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        fatalError("init(realm:schema:) has not been implemented")
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
}

class RealmDetails: Object , JSONModel {
    @objc dynamic var id = 0
    @objc dynamic var name: String?
    @objc dynamic var descrip: String?
    @objc dynamic var thumImage: RealmThumbImage?
    @objc dynamic var title: String?
    @objc dynamic var links: [RealmLink] = []
    
    required init?(parameter: JSON) {
        id = parameter["id"].intValue
        name = parameter["name"].stringValue
        descrip = parameter["description"].stringValue
        title = parameter["title"].stringValue
        thumImage = RealmThumbImage(parameter: parameter["thumbnail"])
        
        if let jasonArray = parameter["urls"].array {
            for json in jasonArray {
                links.append(RealmLink(parameter: json))
            }
        }
        super.init(value: parameter)
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        fatalError("init(realm:schema:) has not been implemented")
    }
    
    required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
    
}

class RealmCharacter: RealmDetails {
    @objc dynamic var charDetails: [ [String:[RealmDetails]] ] = []
    
    required init?(parameter: JSON) {
        super.init(parameter: parameter)
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        fatalError("init(realm:schema:) has not been implemented")
    }
    
    required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
    
}

class RealmThumbImage: Object, JSONModel {
    
    @objc dynamic var path: String = ""
    @objc dynamic var imageExtension: String = ""
    func fullPath() -> String {
        return "\(path).\(imageExtension)"
    }
    required init(parameter: JSON) {
        path = parameter["path"].stringValue
        imageExtension = parameter["extension"].stringValue
        super.init()
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        fatalError("init(realm:schema:) has not been implemented")
    }
    
    required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
    
}

class RealmCharDetaial: Object, JSONModel{
    @objc dynamic var collectionURI: String?
    @objc dynamic var items: [RealmItem] = []
    @objc dynamic var returned: Int = 0
    
    required init(parameter: JSON) {
        collectionURI = parameter["collectionURI"].stringValue
        returned = parameter["returned"].intValue
        
        if let jasonArray = parameter["items"].array {
            for json in jasonArray {
                items.append(RealmItem(parameter: json))
            }
        }
        super.init()
        
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        fatalError("init(realm:schema:) has not been implemented")
    }
    
    required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
}

class RealmItem: Object{
    @objc dynamic var name: String?
    @objc dynamic var resourceURI: String?
    
    init(parameter: JSON) {
        name = parameter["name"].stringValue
        resourceURI = parameter["resourceURI"].stringValue
        super.init()
        
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        fatalError("init(realm:schema:) has not been implemented")
    }
    
    required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
}

class RealmLink: Object {
    @objc dynamic var type: String?
    @objc dynamic var url: String?
    
    init(parameter: JSON) {
        type = parameter["type"].stringValue
        url = parameter["url"].stringValue
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        fatalError("init(realm:schema:) has not been implemented")
    }
}
*/

// realms
//    let charResponce = res as! CharResponce
//    let realmCharResponce = res as! RealmCharResponce
//
//
//    let realm = try! Realm()
//    try! realm.write {
//    realm.add(realmCharResponce.charList)
//    }


//    let realm = try! Realm()
//
//    try! realm.write {
//    var realmCharList = [RealmDetails]()
//    for i in (charResponce?.charList)! {
//    realmCharList[0].descrip = i.description
//    realmCharList[0].links[0].type = i.links[0].type
//
//
//    }
//    realm.add(realmCharList)
//    }
