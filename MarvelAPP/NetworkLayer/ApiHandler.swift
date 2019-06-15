//
//  ApiHandler.swift
//  MarvelAPP
//
//  Created by Atta Amed on 6/11/19.
//  Copyright © 2019 Atta Amed. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ApiHandler {
    
    static var delegate: HandleErrors!
    
    class func request<T: JSONModel >(url: String , success:@escaping (T) -> Void, method: HTTPMethod, paramter: [String: Any] ){

        Alamofire.request( MarvelAPIConfig.URL + url , method: method, parameters: paramter, encoding: URLEncoding.default , headers: nil).responseJSON { (responseObject) -> Void in
            print(responseObject)
            if responseObject.result.isSuccess  {
                
                let res = JSON(responseObject.result.value!)
                if let finalRes = T(parameter: res) {
                    success(finalRes)
                }
                
                
            } else if responseObject.result.isFailure {
                delegate?.handleFailuer()
            } else {
                delegate?.handleError(error: "201")
            }
        }
    }
    
}

// will handle all failuer and errors in webservice
protocol HandleErrors {
    func handleError(error: String)
    func handleFailuer()
}
