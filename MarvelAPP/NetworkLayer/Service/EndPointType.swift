//
//  EndPointType.swift
//  MarvelAPP
//
//  Created by Atta Amed on 6/23/19.
//  Copyright © 2019 Atta Amed. All rights reserved.
//

import Foundation

protocol EndPointType {
    
    var baseURL: URL {get}
    var path: String {get}
    var httpMethod: HTTPMethod2 {get}
    var task : HTTPTask {get}
    var headers: HTTPHeaders? {get}
}
