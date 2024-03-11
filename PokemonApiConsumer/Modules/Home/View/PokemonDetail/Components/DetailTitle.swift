//
//  DetailTitle.swift
//  PokemonApiConsumer
//
//  Created by Leonardo Leite on 11/03/24.
//

import UIKit

class DetailTitle: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setConfiguration()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setConfiguration() {
        setProperties()
    }
    
    private func setProperties() {
        self.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.8)
        self.font = .preferredFont(forTextStyle: .title2)
    }
}
