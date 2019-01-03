//
//  MyView.swift
//  KindOfADrag
//
//  Created by Gene De Lisa on 9/2/14.
//  Copyright (c) 2014 Gene De Lisa. All rights reserved.
//

import UIKit

class SymbolView: UIView {
    
    var name: String = ""
    
    var fillColor = UIColor.red
    
    var strokeColor = UIColor.blue
    
    var size: CGFloat = 32
    
    init(name: String, fill: UIColor, stroke: UIColor, size: CGFloat) {
        self.name = name
        self.fillColor = fill
        self.strokeColor = stroke
        self.size = size
   
        super.init(frame: CGRect(x: 0, y: 0, width: size, height: size))
        
        self.backgroundColor = .clear
        self.clipsToBounds = true
        self.layer.cornerRadius = size / 4
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {

       let content = UIBezierPath(roundedRect: self.bounds, cornerRadius: size / 4)
        fillColor.setFill()
        content.fill()
        content.lineWidth = 8.0
        strokeColor.setStroke()
        content.stroke()
    }
    
}
