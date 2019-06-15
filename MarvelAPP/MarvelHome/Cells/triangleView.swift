//
//  triangleView.swift
//  MarvelAPP
//
//  Created by Atta Amed on 6/11/19.
//  Copyright © 2019 Atta Amed. All rights reserved.
//

import UIKit

class triangleView: UIView {

    override func draw(_ rect: CGRect) {
        
        let path = UIBezierPath.init()
        
        // top left
        path.move(to:  CGPoint(x: bounds.size.width * 0.05,
                               y: 0))
        
        // top right
        path.addLine(to: CGPoint(x: bounds.size.width,
                                 y: 0))
        
        // bottom left offset
        path.addLine(to: CGPoint(x: bounds.size.width * 0.95,
                                 y: bounds.size.height))
        
        // bottom right
        path.addLine(to: CGPoint(x: 0 ,
                                 y: bounds.size.height))
        
        path.close()
        
        // change fill color here.
        UIColor.white.setFill()
        path.fill()
        
    }

}
