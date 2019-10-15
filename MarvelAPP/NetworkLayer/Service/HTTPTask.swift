//
//  HTTPTask.swift
//  MarvelAPP
//
//  Created by Atta Amed on 6/23/19.
//  Copyright © 2019 Atta Amed. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String:String]

public enum HTTPTask {
    case request
    
    case requestParameters(paremetersInBody: Parameters?, urlParameters: Parameters?)
    
    
    case requestParametersWithHeaders(paremetersInBody: Parameters?, urlParameters: Parameters?, additionHeaders: HTTPHeaders?)
    
}
