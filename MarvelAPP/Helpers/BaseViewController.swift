//
//  BaseViewController.swift
//  MarvelAPP
//
//  Created by Atta Amed on 6/16/19.
//  Copyright © 2019 Atta Amed. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController , HandleErrors {

    lazy var boxView: UIView! = { return self.newLoadingIndicator() }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ApiHandler.delegate = self
    }
    
    func handleError(error: String) {
        hideLoadingIndicator(boxView)
        self.alert(message: error )
    }
    func handleFailuer() {
        hideLoadingIndicator(boxView)
        self.showFaileuirAlert(error: "")
    }
    
    
}
