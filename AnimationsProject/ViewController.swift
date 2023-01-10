//
//  ViewController.swift
//  AnimationsProject
//
//  Created by Karina gurachevskaya on 20.12.22.
//

import UIKit

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttonsStackView = UIStackView()
        buttonsStackView.axis = .vertical
        
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsStackView)
        
        NSLayoutConstraint.activate([
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            buttonsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            buttonsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        let firstAnimationButton = UIButton()
        let secondAnimationButton = UIButton()
        let thirdAnimationButton = UIButton()
        let fourthAnimationButton = UIButton()
        let fifthAnimationButton = UIButton()

        buttonsStackView.addArrangedSubview(firstAnimationButton)
        buttonsStackView.addArrangedSubview(secondAnimationButton)
        buttonsStackView.addArrangedSubview(thirdAnimationButton)
        buttonsStackView.addArrangedSubview(fourthAnimationButton)
        buttonsStackView.addArrangedSubview(fifthAnimationButton)

        buttonsStackView.arrangedSubviews.enumerated().forEach { index, view in
            let button = view as? UIButton
            button?.setTitle("\(index + 1) Animation", for: .normal)
            button?.setTitleColor(.black, for: .normal)
            button?.addTarget(self, action: #selector(openAnimationScreen), for: .touchUpInside)

            view.tag = index
            NSLayoutConstraint.activate([
                view.heightAnchor.constraint(equalToConstant: 50)
            ])
        }
    }
    
    @objc func openAnimationScreen(_ sender: UIButton) {
        var viewController = UIViewController()
        viewController.modalPresentationStyle = .fullScreen
        
        switch sender.tag {
        case 0:
            viewController = FirstAnimationViewController()
        case 1:
            let st = UIStoryboard(name: "ItemsViewController", bundle: nil)
            viewController = st.instantiateViewController(withIdentifier: "ItemsViewController")
        case 2:
            viewController = TransactionViewController()
        case 3:
            viewController = PresentationLayerViewController()
        case 4:
            viewController = ExplicitAnimationViewController()
        default:
            return
        }
        
        present(viewController, animated: true, completion: nil)
    }
}

