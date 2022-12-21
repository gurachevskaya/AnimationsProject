//
//  FirstAnimationViewController.swift
//  AnimationsProject
//
//  Created by Karina gurachevskaya on 20.12.22.
//

import UIKit

class FirstAnimationViewController: UIViewController {
    
    var animator: UIViewPropertyAnimator!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(slider)

        slider.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        slider.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        
        slider.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)

        let redBox = UIView(frame: CGRect(x: -64, y: 0, width: 128, height: 128))
        redBox.translatesAutoresizingMaskIntoConstraints = false
        redBox.backgroundColor = UIColor.red
        redBox.center.y = view.center.y
        view.addSubview(redBox)
        
        animator = UIViewPropertyAnimator(duration: 2, curve: .easeInOut) { [unowned self, redBox] in
            redBox.center.x = self.view.frame.width
            redBox.transform = CGAffineTransform(rotationAngle: CGFloat.pi).scaledBy(x: 0.001, y: 0.001)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        animator.stopAnimation(true)
        animator = nil
    }
    
    @objc func sliderChanged(_ sender: UISlider) {
        animator.fractionComplete = CGFloat(sender.value)
    }
}
