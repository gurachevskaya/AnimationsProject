//
//  ItemsTableView.swift
//  AnimationsProject
//
//  Created by Karina gurachevskaya on 22.12.22.
//

import UIKit

final class ItemsTableView: UITableView {
    required init!(coder: NSCoder) {
        super.init(coder: coder)
        dataSource = diffableDataSource
        delegate = self
        updateSnapshot()
    }
    
    var handleSelection: ( (Item) -> Void )!
    
    func addItem(_ item: Item) {
        itemSet.insert(item)
        updateSnapshot()
    }
    
    private var itemSet = Set(
        (0...2).map { _ in Item.allCases.randomElement()! }
    )
    
    private lazy var diffableDataSource = UITableViewDiffableDataSource<Section, Item>(tableView: self) {
        tableView, indexPath, item in
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.accessoryType = .none
        cell.textLabel!.text = item.rawValue
        cell.imageView!.image = .init(item: item)
        return cell
    }
}

private extension ItemsTableView {
    typealias Section = Bool
    
    var itemArray: [Item] {
        Item.allCases.filter(itemSet.contains)
    }
    
    func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.init()])
        snapshot.appendItems(itemArray)
        diffableDataSource.apply(snapshot)
    }
}

extension ItemsTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        deselectRow(at: indexPath, animated: true)
        handleSelection(itemArray[indexPath.row])
    }
}
