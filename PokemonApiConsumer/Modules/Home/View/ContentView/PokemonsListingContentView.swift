//
//  PokemonsListingContentView.swift
//  PokemonApiConsumer
//
//  Created by Izadora Matias on 15/02/24.
//

import UIKit

class PokemonsListingContentView: UIView {
    
    var pokemonTableView: PokemonsTableView = {
        let tableView = PokemonsTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()
    var screenLoader: PokemonsLoaderIndicatorView = {
        let loader = PokemonsLoaderIndicatorView()
        loader.translatesAutoresizingMaskIntoConstraints = false

        return loader
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setConfigurations()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setConfigurations() {
        self.setConstraints()
    }
    
    private func setConstraints() {
        self.addSubview(pokemonTableView)
        self.addSubview(screenLoader)
                
        NSLayoutConstraint.activate([
            pokemonTableView.topAnchor.constraint(equalTo: self.topAnchor),
            pokemonTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            pokemonTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            pokemonTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            screenLoader.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            screenLoader.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            screenLoader.topAnchor.constraint(equalTo: pokemonTableView.bottomAnchor, constant: -15)
        ])
    }
}
