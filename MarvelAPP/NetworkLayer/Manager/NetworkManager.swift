//
//  NetworkManager.swift
//  MarvelAPP
//
//  Created by Atta Amed on 10/15/19.
//  Copyright © 2019 Atta Amed. All rights reserved.
//

import Foundation

struct NetworkManager {
    static let environment: NetworkEnvironment = .production
    static let movieApiKey = "API key"
    private let router = Router<MovieApi>()
    enum NetworkResponse: String {
        // TODO:- add all response options
        case success
        case failed = " network error"
    }
    enum Result<String> {
        case success
        case failuer(String)
    }
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        // TODO:- Add all status code rang
        case 200...299:
            return .success
            
        default:
            return .failuer(NetworkResponse.failed.rawValue)
        }
    }
    func getMovies(page: Int, completion: @escaping (_ movie: [Movie]?, _ error: String?)->()) {
        router.request(.newMovies(page: page)) { (data, response, error) in
            if error != nil{
                completion(nil, "error")
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.failed.rawValue)
                        return
                    }
                    do{
                        let apiResponse =  try JSONDecoder().decode(MovieApiResponse.self, from: responseData)
                        completion(apiResponse.movies, nil)
                    } catch {
                        completion(nil, NetworkResponse.failed.rawValue)
                    }
                case .failuer(_):
                    completion(nil, NetworkResponse.failed.rawValue)
                }
            }
        }
        
    }
}
