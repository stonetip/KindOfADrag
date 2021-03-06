//
//  ViewController.swift
//  KindOfADrag
//
//  Created by Gene De Lisa on 9/2/14.
//  Copyright (c) 2014 Gene De Lisa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    /// the object we're dragging
    var selectedSymbol:SymbolView?
    
    /// the subview containing lines drawn between the objects
    var linesView:UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        linesView = UIView()
        linesView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        linesView.translatesAutoresizingMaskIntoConstraints = false
        linesView.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 0.25)
        
        // add the lines view to the main view
        view.addSubview(linesView)
        
        // set up its constraints
        view.addConstraints([
            NSLayoutConstraint(item: linesView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: linesView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1.0, constant: 0)
            ])
        
        /// define a stroke color for all the objects
        let strokeColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.63)
        
        let symbol1 = SymbolView(name: "symbol 1", fill: UIColor(red: 1.0, green: 0.0, blue: 1.0, alpha: 0.25), stroke: strokeColor, size: 48)
        view.addSubview(symbol1)
        symbol1.center = CGPoint(x: 48, y: 96)
        
        let symbol2 = SymbolView(name: "symbol 2", fill: UIColor(red: 0.0, green: 1.0, blue: 1.0, alpha: 0.25), stroke: strokeColor, size: 48)
        view.addSubview(symbol2)
        symbol2.center = CGPoint(x: 96, y: 192)
        
        let symbol3 = SymbolView(name: "symbol 3", fill: UIColor(red: 0.0, green: 0.75, blue: 0.0, alpha: 0.25), stroke: strokeColor, size: 48)
        view.addSubview(symbol3)
        symbol3.center = CGPoint(x: 144, y: 96)
        
        setupGestures()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupGestures() {
        let panGestureRecognizer = UIPanGestureRecognizer(target:self, action:#selector(dragSymbol(_:)))
        panGestureRecognizer.maximumNumberOfTouches = 1
        panGestureRecognizer.minimumNumberOfTouches = 1
        self.view.addGestureRecognizer(panGestureRecognizer)
    }
    
    
    
    @objc func dragSymbol(_ recognizer:UIPanGestureRecognizer) {
        
        let currentLoc:CGPoint = recognizer.location(in: self.view)
        
        switch recognizer.state {
            
        case .began:
            
            selectedSymbol = view.hitTest(currentLoc, with: nil) as? SymbolView
            
            guard selectedSymbol != nil else { return }
            
            self.view.bringSubview(toFront: selectedSymbol!)
            print("hit valid symbol: \(selectedSymbol!.name)")
            
        case .changed:
            guard selectedSymbol != nil else { return }
            
            selectedSymbol!.center = currentLoc
            
            
            // erase any previously rendered lines
            self.linesView.layer.sublayers = nil
            
            let otherSymbols = self.view.subviews.filter{ (($0 as? SymbolView) != nil) && $0 != selectedSymbol} as! [SymbolView]

            for symbol in otherSymbols{
                
                print(symbol.name)
                
                let layer = createLineLayer(symbol.center, selectedSymbol!.center)
                
                self.linesView.layer.addSublayer(layer)
            }
            
        case .ended:
            print("ended")
            selectedSymbol = nil
            
        default: break
        }
    }
    
    
    func createLineLayer(_ startPoint:CGPoint, _ endPoint: CGPoint) -> CAShapeLayer {
        
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.strokeColor = UIColor.red.cgColor
        layer.opacity = 0.5
        layer.lineWidth = 4.0
        layer.lineCap = kCALineCapRound
        
        return layer
    }
}

