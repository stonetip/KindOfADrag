//
//  MyView.swift
//  KindOfADrag
//
//  Created by Gene De Lisa on 9/2/14.
//  Copyright (c) 2014 Gene De Lisa. All rights reserved.
//

import UIKit

class LineView: UIView {
    
    
    var stroke = UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 0.5)
    
    var pt1: CGPoint = CGPoint()
    var pt2: CGPoint = CGPoint()
    
    override func draw(_ rect: CGRect) {
        
        if let context = UIGraphicsGetCurrentContext() {
            context.saveGState()
            defer {
                context.restoreGState()
            }
            
            let path = UIBezierPath()
            path.move(to: pt1)
            path.addLine(to: pt2)
            stroke.setStroke()
            path.lineWidth = 2.0
            path.stroke()
            self.backgroundColor = .clear
        }
    }
    
}
