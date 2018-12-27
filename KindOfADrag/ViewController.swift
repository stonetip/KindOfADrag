//
//  ViewController.swift
//  KindOfADrag
//
//  Created by Gene De Lisa on 9/2/14.
//  Copyright (c) 2014 Gene De Lisa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    /// the guy we're dragging
    var selectedView:MyView?
    
    var linesView:UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenSize: CGRect = UIScreen.main.bounds
        linesView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
        self.view.addSubview(linesView!)
        
        
        var myview = MyView()
        view.addSubview(myview)
        myview.frame = CGRect(x: 10, y: 40, width: 48, height: 48)
        myview.vName = "foo"
        
        myview = MyView()
        view.addSubview(myview)
        myview.frame = CGRect(x: 60, y: 80, width: 48, height: 48)
        myview.fillColor = UIColor(red: 1.0, green: 0.5, blue: 1.0, alpha: 1.0).cgColor
        myview.vName = "bar"
        
        myview = MyView()
        view.addSubview(myview)
        myview.frame = CGRect(x: 60, y: 80, width: 48, height: 48)
        myview.fillColor = UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0).cgColor
        myview.vName = "car"
        
        setupGestures()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupGestures() {
        let pan = UIPanGestureRecognizer(target:self, action:#selector(panFunc(_:)))
        pan.maximumNumberOfTouches = 1
        pan.minimumNumberOfTouches = 1
        self.view.addGestureRecognizer(pan)
    }
    
    @objc func panFunc(_ rec:UIPanGestureRecognizer) {
        
        let currentLoc:CGPoint = rec.location(in: self.view)
        
        switch rec.state {
        case .began:
            
            selectedView = view.hitTest(currentLoc, with: nil) as? MyView
            if selectedView != nil {
                self.view.bringSubview(toFront: selectedView!)
                
                print("began dragging \(selectedView!.vName)")
            }
            
//            for subV in self.view.subviews{
//                if let sv = subV as? MyView{
//                    print(sv.vName)
//                    print(sv.center)
//                }
//            }
            
        case .changed:
            if let subview = selectedView {
                
                subview.center.x = currentLoc.x
                
                subview.center.y = currentLoc.y
                
                let otherSubViews = self.view.subviews.filter{ (element) -> Bool in
                    return element != subview
                }
                
                self.linesView!.layer.sublayers = nil
                
                for subV in otherSubViews{
                    if let sv = subV as? MyView{
                        print(sv.vName)
                        print(sv.center)
                        
//                        let lv = LineView()
//                        lv.pt1 = sv.center
//                        lv.pt2 = subview.center
//                        lv.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
                        
                        let path = UIBezierPath()
                        path.move(to: sv.center)
                        path.addLine(to: subview.center)
                        
                        let layer = CAShapeLayer()
                        layer.path = path.cgPath
                        layer.strokeColor = UIColor.red.cgColor
                        layer.lineWidth = 4.0
                       
                        
                        self.linesView!.layer.addSublayer(layer)
                        
                    }
                }
                
            }
            
        case .ended:
            print("ended")
//            if let subview = selectedView {
//
//            }
            selectedView = nil
            
        case .possible:
            print("possible")
        case .cancelled:
            print("cancelled")
            selectedView = nil
        case .failed:
            print("failed")
            selectedView = nil
        }
    }
}

