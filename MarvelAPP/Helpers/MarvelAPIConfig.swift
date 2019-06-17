//
//  MarvelAPIConfig.swift
//  MarvelAPP
//
//  Created by Atta Amed on 6/11/19.
//  Copyright © 2019 Atta Amed. All rights reserved.
//

import Foundation

import CryptoSwift

class MarvelAPIConfig {
    
    static let URL = "http://gateway.marvel.com/v1/public/"
    static let ts = Date().timeIntervalSince1970.description
    static var apikey = "f2f385b7a11b8c2bae357fd4f7fbd58b"
    static var privatekey = "c3e1975bd00dba16a17dc09c36a6e45a566b637c"
    static let hash = "\(ts)\(privatekey)\(apikey)".md5()

}
