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
        
        NSLayoutConstraint.activate([
            self.cardImage.topAnchor.constraint(equalTo: self.topAnchor),
            self.cardImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.cardImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            self.cardImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
        ])
    }
}
