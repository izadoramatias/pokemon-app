//
//  PokemonCardModal.swift
//  PokemonApiConsumer
//
//  Created by Izadora Matias on 28/02/24.
//

import UIKit

class PokemonCardModal: UIView {
   
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setConfigurations()
    }
    
    let screenLoader: PokemonsLoaderIndicatorView = {
        var loader = PokemonsLoaderIndicatorView()
        loader.translatesAutoresizingMaskIntoConstraints = false

        return loader
    }()
        
    let modalView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
                
        return view
    }()
    
    public let modalBackground: UIView = {
        let background = UIView()
        background.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.6)
        background.translatesAutoresizingMaskIntoConstraints = false
        background.backgroundColor = .red
        
        return background
    }()
    
    public let cardImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    private func setConfigurations() {
        self.setConstraints()
    }
    
    private func setConstraints() {
        self.addSubview(cardImage)
        self.cardImage.addSubview(self.screenLoader)
        
        NSLayoutConstraint.activate([
            self.cardImage.topAnchor.constraint(equalTo: self.topAnchor),
            self.cardImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.cardImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            self.cardImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            
            self.screenLoader.centerYAnchor.constraint(equalTo: self.cardImage.centerYAnchor),
            self.screenLoader.centerXAnchor.constraint(equalTo: self.cardImage.centerXAnchor),

        ])
    }
}
