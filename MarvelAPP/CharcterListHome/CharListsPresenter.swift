//
//  CharListsPresenter.swift
//  MarvelAPP
//
//  Created by Atta Amed on 6/18/19.
//  Copyright © 2019 Atta Amed. All rights reserved.
//

import Foundation

class CharListPresenter: BasePresenter {
    
    weak var charLisDelegate: CharListPresenterDelegate!
    var charResponce: CharResponce?
    
    func fetchCharacters(limit: Int, count: Int, offset: Int) {
        let paramter = ["apikey": MarvelAPIConfig.apikey,
                        "ts": MarvelAPIConfig.ts,
                        "hash": MarvelAPIConfig.hash,
                        "limit": limit,
                        "offset": offset] as [String : Any]
        ApiHandler.request(url: "characters", success: self.successFetchCharacters, method: .get, paramter: paramter)
    }
    
    fileprivate func successFetchCharacters(res: CharListResponce){
        charResponce = res.data
        charLisDelegate.onSuccessFetchCharacters(charResponce: charResponce)
    }
}

protocol CharListPresenterDelegate: class {
    func onSuccessFetchCharacters(charResponce: CharResponce?)
}
