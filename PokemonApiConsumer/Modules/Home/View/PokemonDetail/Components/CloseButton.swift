//
//  CloseButton.swift
//  PokemonApiConsumer
//
//  Created by Leonardo Leite on 11/03/24.
//

import UIKit

class CloseButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setConfigurations()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setConfigurations() {
        self.setProperties()
    }
    
    private func setProperties() {
        self.setImage(UIImage(systemName: "multiply.circle.fill"), for: .normal)
        self.tintColor = .lightGray
    }
}
