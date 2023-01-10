//
//  PresentationLayerViewController.swift
//  AnimationsProject
//
//  Created by Karina gurachevskaya on 10.01.23.
//

import UIKit

class PresentationLayerViewController: UIViewController {
    var colorLayer = CALayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        
        colorLayer.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        colorLayer.backgroundColor = UIColor.blue.cgColor
        view.layer.addSublayer(colorLayer)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point = touches.first?.location(in: view) ?? CGPoint()
        
        // The display values of each layer’s properties are stored in a separate layer called the presentation layer
        if (colorLayer.presentation()?.hitTest(point)) != nil {
            // change color
            
            colorLayer.backgroundColor = UIColor(
                red: CGFloat(arc4random()) / CGFloat(UInt32.max),
                green: CGFloat(arc4random()) / CGFloat(UInt32.max),
                blue: CGFloat(arc4random()) / CGFloat(UInt32.max),
                alpha: 1
            ).cgColor
            
        } else {
            // move to that position

            CATransaction.begin()
            CATransaction.setAnimationDuration(3)
            
            colorLayer.position = point
            
            CATransaction.commit()
        }
    }
}
