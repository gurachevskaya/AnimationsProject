//
//  CoreAnimationViewController.swift
//  AnimationsProject
//
//  Created by Karina gurachevskaya on 10.01.23.
//

import UIKit

class CoreAnimationViewController: UIViewController {
    
    var colorLayer = CALayer()
    lazy var layerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemPink
        button.setTitle("Change color", for: .normal)
        button.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        
        view.addSubview(layerView)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            layerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            layerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            layerView.widthAnchor.constraint(equalToConstant: 200),
            layerView.heightAnchor.constraint(equalToConstant: 200),
            
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.topAnchor.constraint(equalTo: layerView.bottomAnchor, constant: 15),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        colorLayer.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        colorLayer.backgroundColor = UIColor.blue.cgColor
        
        layerView.layer.addSublayer(colorLayer)
    }
    
    // MARK: CATransaction
    @objc
    func changeColor() {
        CATransaction.begin()
        CATransaction.setAnimationDuration(1)
        
        colorLayer.backgroundColor = UIColor(
            red: CGFloat(arc4random()) / CGFloat(UInt32.max),
            green: CGFloat(arc4random()) / CGFloat(UInt32.max),
            blue: CGFloat(arc4random()) / CGFloat(UInt32.max),
            alpha: 1
        ).cgColor
        
        CATransaction.setCompletionBlock {
            // applies the rotation animation is executed after the color fade animation’s transaction has been committed and popped off the stack
            // using the default transaction, with the default animation duration of 0.25 seconds.
            var transform = self.colorLayer.affineTransform()
            transform = CGAffineTransformRotate(transform, .pi / 4)
            self.colorLayer.setAffineTransform(transform)
        }
        
        CATransaction.commit()
    }
}
