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
                
        let safeAreaMargins = self.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            pokemonTableView.topAnchor.constraint(equalTo: safeAreaMargins.topAnchor),
            pokemonTableView.bottomAnchor.constraint(equalTo: safeAreaMargins.bottomAnchor),
            pokemonTableView.leadingAnchor.constraint(equalTo: safeAreaMargins.leadingAnchor),
            pokemonTableView.trailingAnchor.constraint(equalTo: safeAreaMargins.trailingAnchor),
            
            screenLoader.trailingAnchor.constraint(equalTo: safeAreaMargins.trailingAnchor),
            screenLoader.leadingAnchor.constraint(equalTo: safeAreaMargins.leadingAnchor),
            screenLoader.topAnchor.constraint(equalTo: pokemonTableView.bottomAnchor, constant: -30),  
        ])
    }
}
