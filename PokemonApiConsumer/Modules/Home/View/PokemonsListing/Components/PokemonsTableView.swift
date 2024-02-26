//
//  PokemonsTableView.swift
//  PokemonApiConsumer
//
//  Created by Izadora Matias on 02/02/24.
//

import UIKit

class PokemonsTableView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConfiguration()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.allowsSelection = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
                
        return tableView
    }()
    
    public func setConfiguration() {
        self.setConstrainst()
    }

    private func setConstrainst() {
        addSubview(tableView)
                
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}


