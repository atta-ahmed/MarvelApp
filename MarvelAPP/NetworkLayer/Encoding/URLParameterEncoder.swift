//
//  URLParameterEncoder.swift
//  MarvelAPP
//
//  Created by Atta Amed on 10/14/19.
//  Copyright © 2019 Atta Amed. All rights reserved.
//

import Foundation

public struct URLParamterEncoder: ParameterEncoder {
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        
        guard let url = urlRequest.url else {
            throw NetworkError.missingUrl
        }
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            urlComponents.queryItems = [URLQueryItem]()
            for (key,value) in parameters {
                let queryItem = URLQueryItem(name:key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("", forHTTPHeaderField: "Content-Type")
        }        
    }
    
    
}
