//
//  Router.swift
//  MarvelAPP
//
//  Created by Atta Amed on 10/15/19.
//  Copyright © 2019 Atta Amed. All rights reserved.
//

import Foundation

class Router<EndPoint: EndPointType>: NetworkRouter {
    private var task: URLSessionTask?
    
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)  {
        let session = URLSession.shared
        do{
            let request = try self.buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                
                completion(data,response,error)
            })
        } catch {
            completion(nil,nil,nil)
        }
        self.task?.resume()
    }
    func cancel(){
        self.task?.cancel()
    }
    
    /**
     1- instantiate a variable request of type URLRequest. Give it our base URL and append the specific path we are going to use.
     2- set the httpMethod of the request equal to that of our EndPoint.
     3- create a do-try-catch block since our encoders throws an error. By creating one big do-try-catch block we don’t have to create a separate block for each try.
     4. Switch on route.task
     5. Depending on the task, call the appropriate encoder.
     **/
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
            cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
            timeoutInterval: 10.0)
        request.httpMethod = route.httpMethod.rawValue
        
        do{
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestParameters(let bodyParamter, let urlParameters):
                try self.configureParameters(bodyParamters: bodyParamter, urlParamters: urlParameters, request: &request)
            case .requestParametersWithHeaders(let bodyParamter, let urlParameters, let additionalHeaders):
                self.addAdditionalHeaders(additionalHeaders, request: &request)
                try self.configureParameters(bodyParamters: bodyParamter, urlParamters: urlParameters, request: &request)
            }
            return request

        } catch {
            throw error
        }
    }
    
    fileprivate func addAdditionalHeaders(_ additonalHeaders: HTTPHeaders?, request: inout URLRequest){
        guard let headers = additonalHeaders else { return}
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
    
    /*
     This function is responsible for encoding our parameters. Since our API expects all bodyParameters as JSON and URLParameters to be URL encoded we just pass the appropriate parameters to its designated encoder. If you are dealing with an API that has varied encoding styles I would suggest amending the HTTPTask to take a encoder Enum. This enum should have all the different styles of encoders you need. Then inside configureParameters add an additional argument of your encoder Enum. Switch on the enum and encode parameters appropriately.
 */
    func configureParameters(bodyParamters: Parameters?, urlParamters: Parameters?, request: inout URLRequest) throws {
        do {
            if let bodyParamters = bodyParamters {
                try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParamters)
            }
            if let urlParamters = urlParamters {
                try JSONParameterEncoder.encode(urlRequest: &request, with: urlParamters)
            }
        } catch {
            throw error
        }
    }
}
