//
//  BasePresenter.swift
//  MarvelAPP
//
//  Created by Atta Amed on 6/17/19.
//  Copyright © 2019 Atta Amed. All rights reserved.
//

import Foundation
//
//  CharListPresenter.swift
//  MarvelAPP
//
//  Created by Atta Amed on 6/12/19.
//  Copyright © 2019 Atta Amed. All rights reserved.
//

import Foundation

class BasePresenter: HandleErrors {

    
    weak var delegate: BasePresenterDelegate!

    func handleError(error: String) {
        delegate.onHandleError(error: error)
    }
    
    func handleFailuer() {
        delegate.onHandleFailuer()
    }
    
    
}

protocol BasePresenterDelegate: class {
    func onHandleError(error: String)
    func onHandleFailuer()
}
