//
//  ParameterEncoding.swift
//  MarvelAPP
//
//  Created by Atta Amed on 6/23/19.
//  Copyright © 2019 Atta Amed. All rights reserved.
//

import Foundation

public typealias Parameters = [String:Any]

public protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

public enum NetworkError: String, Error {
    case parametersNil = "paramters are nil."
    case encodingFailed = ""
    case missingUrl = "nnn"
}
