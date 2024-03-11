//
//  ModalContentView.swift
//  PokemonApiConsumer
//
//  Created by Leonardo Leite on 11/03/24.
//

import UIKit

class ModalContentView: UIView {
    let screenLoader: PokemonsLoaderIndicatorView = {
        var loader = PokemonsLoaderIndicatorView()
        loader.translatesAutoresizingMaskIntoConstraints = false

        return loader
    }()
    
    let card: PokemonCardModal = {
        var card = PokemonCardModal()
        card.translatesAutoresizingMaskIntoConstraints = false
        
        return card
    }()
    
    let closeButton: CloseButton = {
       var button = CloseButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let detailTitle: DetailTitle = {
        var title = DetailTitle()
        title.translatesAutoresizingMaskIntoConstraints = false
        
        return title
    }()
    
    let errorComponent: ErrorComponent = {
        let error = ErrorComponent()
        error.translatesAutoresizingMaskIntoConstraints = false
        
        return error
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
        self.setProperties()
    }
    
    private func setProperties() {
        self.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)
    }
    
    private func setConstraints() {
        self.addSubview(screenLoader)
        self.addSubview(card)
        self.addSubview(closeButton)
        self.addSubview(detailTitle)
        self.addSubview(errorComponent)
        
        NSLayoutConstraint.activate([
            screenLoader.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            screenLoader.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            card.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            card.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30),
            card.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            card.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            
            closeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            closeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),

            detailTitle.topAnchor.constraint(equalTo: self.closeButton.topAnchor),
            detailTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            
            errorComponent.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            errorComponent.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
