//
//  ExplicitAnimationViewController.swift
//  AnimationsProject
//
//  Created by Karina gurachevskaya on 10.01.23.
//

import UIKit

class ExplicitAnimationViewController: UIViewController {
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
    
    @objc
    func changeColor() {
        
        let animation = CABasicAnimation()
        animation.keyPath = "backgroundColor"
      
        let color = UIColor(
            red: CGFloat(arc4random()) / CGFloat(UInt32.max),
            green: CGFloat(arc4random()) / CGFloat(UInt32.max),
            blue: CGFloat(arc4random()) / CGFloat(UInt32.max),
            alpha: 1
        )
        
        animation.toValue = color.cgColor
        
        applyBasicAnimation(animation, toLayer: colorLayer)
    }
    
    func applyBasicAnimation(_ animation: CABasicAnimation, toLayer layer: CALayer) {
        let neededLayer = layer.presentation() != nil ? layer.presentation() : layer
        animation.fromValue = neededLayer?.value(forKeyPath: animation.keyPath ?? "")
        //update the property in advance
        //note: this approach will only work if toValue != nil
        CATransaction.begin()
        // Also, because the layer in this case is not a backing layer, we should disable implicit animations using a CATransaction before setting the property, or the default layer action may interfere with our explicit animation. (In practice, the explicit animation always seems to override the implicit one, but this behavior is not documented, so it’s better to be safe than sorry.)
        CATransaction.setDisableActions(true)
        layer.setValue(animation.toValue, forKeyPath: animation.keyPath ?? "")
        CATransaction.commit()
        
        layer.add(animation, forKey: nil)
    }
}
