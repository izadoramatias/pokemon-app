//
//  ErrorComponent.swift
//  PokemonApiConsumer
//
//  Created by Leonardo Leite on 11/03/24.
//

import UIKit

class ErrorComponent: UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setConfiguration()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private let brokenIcon: UIImageView = {
        var image = UIImage(systemName: "rectangle.portrait.on.rectangle.portrait.slash.fill")
        var icon = UIImageView(image: image)
        icon.tintColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
        icon.contentMode = .center
        
        return icon
    }()
    
    private let errorLabel: UILabel = {
        var error = UILabel()
        error.text = "Não foi possível carregar a imagem"
        error.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.8)
        
        return error
    }()

    private func setConfiguration() {
        self.setProperties()
        self.setConstraints()
    }
    
    private func setProperties() {
        self.axis = .vertical
        self.spacing = CGFloat(6)
    }
    
    private func setConstraints() {
        self.addArrangedSubview(brokenIcon)
        self.addArrangedSubview(errorLabel)
    }
}
