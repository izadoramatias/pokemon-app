//
//  PokemonsTableView.swift
//  PokemonApiConsumer
//
//  Created by Izadora Matias on 02/02/24.
//

import UIKit

class PokemonsTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setConfiguration()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func setConfiguration() {
        self.setProperties()
    }
    
    private func setProperties() {
        self.backgroundColor = .systemBackground
        self.accessibilityIdentifier = "tableView"
        self.allowsSelection = true
    }
}


