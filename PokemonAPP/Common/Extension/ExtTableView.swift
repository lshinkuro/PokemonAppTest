//
//  ExtTableView.swift
//  PokemonAPP
//
//  Created by Macbook on 16/03/23.
//

import Foundation
import UIKit

import UIKit

extension UITableView {
    func setEmptyMessage(message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .systemGray2
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
    
    func setLoading() {
        let activityIndicatorView = UIActivityIndicatorView(style: .medium)
        activityIndicatorView.color = .gray
        self.backgroundView = activityIndicatorView
        activityIndicatorView.startAnimating()
        self.separatorStyle = .none
    }
    
    func registerCell<Cell: UITableViewCell>(_ cellClass: Cell.Type) {
        register(cellClass, forCellReuseIdentifier: String(describing: cellClass))
    }
    
    func registerCellWithNib<Cell: UITableViewCell>(_ cellClass: Cell.Type) {
        let identifier = String(describing: cellClass)
        let nib = UINib(nibName: identifier, bundle: .main)
        register(nib, forCellReuseIdentifier: identifier)
    }
    
    func registerHeaderFooterWithNib<Header: UITableViewHeaderFooterView>(_ headerClass: Header.Type) {
        let identifier = String(describing: headerClass)
        let nib = UINib(nibName: identifier, bundle: .main)
        register(nib, forHeaderFooterViewReuseIdentifier: identifier)
    }
    
    func dequeueReusableCell<Cell: UITableViewCell>(forIndexPath indexPath: IndexPath) -> Cell {
        let identifier = String(describing: Cell.self)
        guard let cell = self.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? Cell else {
            fatalError("Error for cell if: \(identifier) at \(indexPath)")
        }
        return cell
    }
    
    func dequeueReusableHeaderFooter<Header: UITableViewHeaderFooterView>() -> Header {
        let identifier = String(describing: Header.self)
        guard let header = self.dequeueReusableHeaderFooterView(withIdentifier: identifier) as? Header else {
            fatalError("Error for header: \(identifier)")
        }
        return header
    }
}

