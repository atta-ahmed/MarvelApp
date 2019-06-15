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
    var comicsResponce: CharResponce?
    var storiesResponce: CharResponce?
    var eventsResponce: CharResponce?
    var seriesResponce: CharResponce?
    
    let dispatchGroup = DispatchGroup()
    
    func fetchDetails(limit: Int, offset: Int, charId: Int , detailType: String) {
        let paramter = ["apikey": MarvelAPIConfig.apikey,
                        "ts": MarvelAPIConfig.ts,
                        "hash": MarvelAPIConfig.hash,
                        "offset": offset,
                        ] as [String : Any]
        dispatchGroup.enter()
        ApiHandler.request(url: "characters/\(charId)/\(detailType)", success: self.successFetchCharactersDetails, method: .get, paramter: paramter)
    }
    func successFetchCharactersDetails(res: CharListResponce){
        comicsResponce = res.data
        delegate.onSuccessFetchDetails(charResponce: comicsResponce)
        dispatchGroup.leave()
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
        comicsResponce = res.data
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
        storiesResponce = res.data
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
        eventsResponce = res.data
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
        seriesResponce = res.data
        delegate.onSuccessFetchSeries(seriesResponce: seriesResponce)
        dispatchGroup.leave()
    }
    
    
    func setupdispatchGroup() {
        dispatchGroup.notify(queue: .main) {
           self.delegate.onSuccessFetchAll()
        }
    }
    
    
}

protocol DetailsPresenterDelegate: class {
    func onSuccessFetchDetails(charResponce: CharResponce?)
   
    func onSuccessFetchComics(comicsResponce: CharResponce?)
    func onSuccessFetchStories(storiesResponce: CharResponce?)
    func onSuccessFetchEvents(eventsResponce: CharResponce?)
    func onSuccessFetchSeries(seriesResponce: CharResponce?)

    func onSuccessFetchAll()


}
