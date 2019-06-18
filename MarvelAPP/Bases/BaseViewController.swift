//
//  BaseViewController.swift
//  MarvelAPP
//
//  Created by Atta Amed on 6/16/19.
//  Copyright © 2019 Atta Amed. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController , BasePresenterDelegate {
  
    lazy var boxView: UIView! = { return self.newLoadingIndicator() }()
    var basePresenter = BasePresenter.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        basePresenter.delegate = self
    }
    func onHandleError(error: String) {
        hideLoadingIndicator(boxView)
        self.alert(message: error )
    }
    
    func onHandleFailuer() {
        hideLoadingIndicator(boxView)
        self.showFaileuirAlert(error: "Server Error")
    }
    
    
}
