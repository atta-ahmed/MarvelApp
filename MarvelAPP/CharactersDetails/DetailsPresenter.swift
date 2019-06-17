//
//  DetailsPresenter.swift
//  MarvelAPP
//
//  Created by Atta Amed on 6/15/19.
//  Copyright © 2019 Atta Amed. All rights reserved.
//

import Foundation
class DetailsPresenter: BasePresenter {
    
    weak var detailsdelegate: DetailsPresenterDelegate!
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
      //  comicsResponce = res.data?.charList
     //   delegate.onSuccessFetchDetails(charResponce: comicsResponce)
    }

    
    func fetchComics(limit: Int, offset: Int, charId: Int) {
           dispatchGroup.enter()
        let paramter = ["apikey": MarvelAPIConfig.apikey,
                        "ts": MarvelAPIConfig.ts,
                        "hash": MarvelAPIConfig.hash,
                        "offset": offset,
                        ] as [String : Any]
        ApiHandler.request(url: "characters/\(charId)/comics", success: self.successFetchComics, method: .get, paramter: paramter)
    }
    func successFetchComics(res: CharListResponce){
           dispatchGroup.leave()
        comicsResponce = res.data?.charList
        detailsdelegate.onSuccessFetchComics(comicsResponce: comicsResponce)
    }
    
    
    func fetchStories(limit: Int, offset: Int, charId: Int) {
        dispatchGroup.enter()
        let paramter = ["apikey": MarvelAPIConfig.apikey,
                        "ts": MarvelAPIConfig.ts,
                        "hash": MarvelAPIConfig.hash,
                        "offset": offset,
                        ] as [String : Any]
        ApiHandler.request(url: "characters/\(charId)/stories", success: self.successFetchStoris, method: .get, paramter: paramter)
    }
    func successFetchStoris(res: CharListResponce){
        dispatchGroup.leave()
        storiesResponce = res.data?.charList
        detailsdelegate.onSuccessFetchStories(storiesResponce: storiesResponce)
    }
    
    func fetchEvents(limit: Int, offset: Int, charId: Int) {
                dispatchGroup.enter()
        let paramter = ["apikey": MarvelAPIConfig.apikey,
                        "ts": MarvelAPIConfig.ts,
                        "hash": MarvelAPIConfig.hash,
                        "offset": offset,
                        ] as [String : Any]
        ApiHandler.request(url: "characters/\(charId)/events", success: self.successFetchEvents, method: .get, paramter: paramter)
    }
    func successFetchEvents(res: CharListResponce){
        dispatchGroup.leave()
        eventsResponce = res.data?.charList
        detailsdelegate.onSuccessFetchEvents(eventsResponce: eventsResponce)
    }
    
    func fetchSeries(limit: Int, offset: Int, charId: Int) {
        dispatchGroup.enter()
        let paramter = ["apikey": MarvelAPIConfig.apikey,
                        "ts": MarvelAPIConfig.ts,
                        "hash": MarvelAPIConfig.hash,
                        "offset": offset,
                        ] as [String : Any]
        ApiHandler.request(url: "characters/\(charId)/series", success: self.successFetchSeries, method: .get, paramter: paramter)
    }
    func successFetchSeries(res: CharListResponce){
        dispatchGroup.leave()
        seriesResponce = res.data?.charList
        detailsdelegate.onSuccessFetchSeries(seriesResponce: seriesResponce)
    }
    
    func setupdispatchGroup() {
        dispatchGroup.notify(queue: .main) {
            self.detailsdelegate.onSuccessFetchAll(characterDetail: self.characterDetail)
        }
    }
    
    override func handleFailuer() {
        dispatchGroup.leave()
        detailsdelegate.onError()
        super.handleFailuer()
    }
    
    override func handleError(error: String) {
        dispatchGroup.leave()
        detailsdelegate.onError()
        super.handleError(error: error)
    }
    
}

protocol DetailsPresenterDelegate: class {
   
    func onSuccessFetchComics(comicsResponce: [Details]?)
    func onSuccessFetchStories(storiesResponce: [Details]?)
    func onSuccessFetchEvents(eventsResponce: [Details]?)
    func onSuccessFetchSeries(seriesResponce: [Details]?)

    func onSuccessFetchAll(characterDetail: Character?)
    func onError()


}
