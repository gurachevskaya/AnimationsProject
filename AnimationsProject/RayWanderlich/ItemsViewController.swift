//
//  ItemsViewController.swift
//  AnimationsProject
//
//  Created by Karina gurachevskaya on 22.12.22.
//

import UIKit

final class ItemsViewController: UIViewController {
    
    @IBOutlet private var tableView: ItemsTableView! {
        didSet { tableView.handleSelection = showItem }
    }
    
    @IBOutlet private var menuButton: UIButton!
    @IBOutlet private var titleLabel: UILabel!
    
    @IBOutlet private var menuHeightConstraint: NSLayoutConstraint!
        
    private var slider: HorizontalItemSlider!
    private var menuIsOpen = false
}

extension ItemsViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slider = HorizontalItemSlider(in: view) { [unowned self] item in
            self.tableView.addItem(item)
            self.transitionCloseMenu()
        }
        titleLabel.superview!.addSubview(slider)
    }
}

private extension ItemsViewController {
    @IBAction func toggleMenu() {
        menuIsOpen.toggle()
        titleLabel.text = menuIsOpen ? "Select Item!" : "Packing List"
        view.layoutIfNeeded()
        menuHeightConstraint.constant = menuIsOpen ? 200 : 80
        
        UIView.animate(
            withDuration: 1 / 3, delay: 0,
            options: .curveEaseIn,
            animations: { self.view.layoutIfNeeded() }
        )
    }
    
    func showItem(_ item: Item) {
        let imageView = UIImageView(item: item)
        imageView.backgroundColor = .init(white: 0, alpha: 0.5)
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
    }
    
    func transitionCloseMenu() {
        delay(seconds: 0.35, execute: toggleMenu)
    }
}

private func delay(seconds: TimeInterval, execute: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: execute)
}
