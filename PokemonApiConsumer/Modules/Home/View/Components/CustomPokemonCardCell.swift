//
//  CustomPokemonCardCell.swift
//  PokemonApiConsumer
//
//  Created by Izadora Matias on 08/02/24.
//

import UIKit

class CustomPokemonCardCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setConfigurations()
        return
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        return
    }
    
    public let imgView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()
    
    private func setConfigurations() {
        self.setConstraints()
    }
    
    private func setConstraints() {
        addSubview(imgView)
        
        NSLayoutConstraint.activate([
            imgView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imgView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imgView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            imgView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    
}
