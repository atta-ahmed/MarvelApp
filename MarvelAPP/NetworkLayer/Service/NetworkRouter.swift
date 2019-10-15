//
//  NetworkRouter.swift
//  MarvelAPP
//
//  Created by Atta Amed on 10/14/19.
//  Copyright © 2019 Atta Amed. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
    
}
