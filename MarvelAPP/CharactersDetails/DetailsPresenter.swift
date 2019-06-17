//
//  DetailsPresenter.swift
//  MarvelAPP
//
//  Created by Atta Amed on 6/15/19.
//  Copyright © 2019 Atta Amed. All rights reserved.
//

import Foundation
class DetailsPresenter {
    
    weak var delegate: DetailsPresenterDelegate!
    var comicsResponce: [Details]?
    var storiesResponce: [Details]?
    var eventsResponce: [Details]?
    var seriesResponce: [Details]?
    
    var characterDetail: Character?
    
    let dispatchGroup = DispatchGroup()
    
    func fetchDetails(limit: Int, offset: Int, charId: Int , detailType: String) {
        let paramter = ["apikey": MarvelAPIConfig.apikey,
                        "ts": MarvelAPIConfig.ts,
                        "hash": MarvelAPIConfig.hash,
                        "offset": offset,
                        ] as [String : Any]
        ApiHandler.request(url: "characters/\(charId)/\(detailType)", success: self.successFetchCharactersDetails, method: .get, paramter: paramter)
    }
    func successFetchCharactersDetails(res: CharListResponce){
        comicsResponce = res.data?.charList
     //   delegate.onSuccessFetchDetails(charResponce: comicsResponce)
    }

    
    func fetchComics(limit: Int, offset: Int, charId: Int) {
        let paramter = ["apikey": MarvelAPIConfig.apikey,
                        "ts": MarvelAPIConfig.ts,
                        "hash": MarvelAPIConfig.hash,
                        "offset": offset,
                        ] as [String : Any]
        dispatchGroup.enter()
        ApiHandler.request(url: "characters/\(charId)/comics", success: self.successFetchComics, method: .get, paramter: paramter)
    }
    func successFetchComics(res: CharListResponce){
        comicsResponce = res.data?.charList
        delegate.onSuccessFetchComics(comicsResponce: comicsResponce)
        dispatchGroup.leave()
    }
    
    
    func fetchStories(limit: Int, offset: Int, charId: Int) {
        let paramter = ["apikey": MarvelAPIConfig.apikey,
                        "ts": MarvelAPIConfig.ts,
                        "hash": MarvelAPIConfig.hash,
                        "offset": offset,
                        ] as [String : Any]
        dispatchGroup.enter()
        ApiHandler.request(url: "characters/\(charId)/stories", success: self.successFetchStoris, method: .get, paramter: paramter)
    }
    func successFetchStoris(res: CharListResponce){
        storiesResponce = res.data?.charList
        delegate.onSuccessFetchStories(storiesResponce: storiesResponce)
        dispatchGroup.leave()
    }
    
    func fetchEvents(limit: Int, offset: Int, charId: Int) {
        let paramter = ["apikey": MarvelAPIConfig.apikey,
                        "ts": MarvelAPIConfig.ts,
                        "hash": MarvelAPIConfig.hash,
                        "offset": offset,
                        ] as [String : Any]
        dispatchGroup.enter()
        ApiHandler.request(url: "characters/\(charId)/events", success: self.successFetchEvents, method: .get, paramter: paramter)
    }
    func successFetchEvents(res: CharListResponce){
        eventsResponce = res.data?.charList
        delegate.onSuccessFetchEvents(eventsResponce: eventsResponce)
        dispatchGroup.leave()
    }
    
    func fetchSeries(limit: Int, offset: Int, charId: Int) {
        let paramter = ["apikey": MarvelAPIConfig.apikey,
                        "ts": MarvelAPIConfig.ts,
                        "hash": MarvelAPIConfig.hash,
                        "offset": offset,
                        ] as [String : Any]
        dispatchGroup.enter()
        ApiHandler.request(url: "characters/\(charId)/series", success: self.successFetchSeries, method: .get, paramter: paramter)
    }
    func successFetchSeries(res: CharListResponce){
        seriesResponce = res.data?.charList
        delegate.onSuccessFetchSeries(seriesResponce: seriesResponce)
        dispatchGroup.leave()
    }
    
    
    func setupdispatchGroup() {
        dispatchGroup.notify(queue: .main) {
            self.delegate.onSuccessFetchAll(characterDetail: self.characterDetail)
        }
    }
    
    
}

protocol DetailsPresenterDelegate: class {
   
    func onSuccessFetchComics(comicsResponce: [Details]?)
    func onSuccessFetchStories(storiesResponce: [Details]?)
    func onSuccessFetchEvents(eventsResponce: [Details]?)
    func onSuccessFetchSeries(seriesResponce: [Details]?)

    func onSuccessFetchAll(characterDetail: Character?)


}
