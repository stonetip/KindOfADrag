//
//  MyView.swift
//  KindOfADrag
//
//  Created by Gene De Lisa on 9/2/14.
//  Copyright (c) 2014 Gene De Lisa. All rights reserved.
//

import UIKit

class LineView: UIView {
    
    
    var strokeColor = UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 0.5)
    
    var pt1: CGPoint = CGPoint()
    var pt2: CGPoint = CGPoint()
    
    override func draw(_ rect: CGRect) {
        
        
        let path = UIBezierPath()
        path.move(to: pt1)
        path.addLine(to: pt2)
        
  
//
//        strokeColor.setStroke()
//        path.lineWidth = 3.0
//        path.lineCapStyle = .round
//        path.stroke()
        
        let line = CAShapeLayer()
        line.path = path.cgPath
        line.strokeColor = strokeColor.cgColor
        line.lineWidth = 2.0
        line.lineCap = kCALineCapRound
        
    }
    
}
