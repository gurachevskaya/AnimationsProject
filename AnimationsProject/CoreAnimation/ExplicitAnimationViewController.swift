//
//  ExplicitAnimationViewController.swift
//  AnimationsProject
//
//  Created by Karina gurachevskaya on 10.01.23.
//

import UIKit

class ExplicitAnimationViewController: UIViewController, CAAnimationDelegate {
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
    
    // MARK: CAKeyFramedAnimation
    @objc
    func changeColor() {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "backgroundColor"
        animation.duration = 4

        // it’s possible to create animations that end on a different value than they begin. In that case, we would need to manually update the property value to match the last keyframe before we trigger the animation
        animation.values = [
            UIColor.blue.cgColor,
            UIColor.red.cgColor,
            UIColor.green.cgColor,
            UIColor.blue.cgColor
        ]
        
        colorLayer.add(animation, forKey: nil)
        
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0, y: 150))
        bezierPath.addCurve(to: CGPoint(x: 300, y: 150), controlPoint1: CGPoint(x: 75, y: 0), controlPoint2: CGPoint(x: 225, y: 300))
        
        let positionAnimation = CAKeyframeAnimation()
        positionAnimation.keyPath = "position"
        positionAnimation.duration = 4.0
        positionAnimation.path = bezierPath.cgPath
        
        colorLayer.add(positionAnimation, forKey: nil)
    }
    
    // MARK: CABasicAnimation
    /*
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
        
        // without delegate
        //        applyBasicAnimation(animation, toLayer: colorLayer)

        // using CAAnimation delegate
        animation.delegate = self
        colorLayer.add(animation, forKey: nil)
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
    */
    
    // using CAAnimation delegate
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        let basicAnimation = anim as? CABasicAnimation
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        colorLayer.backgroundColor = basicAnimation?.toValue as! CGColor
        CATransaction.commit()
    }
}
