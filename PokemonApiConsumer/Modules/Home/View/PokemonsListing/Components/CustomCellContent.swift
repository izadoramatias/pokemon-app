//
//  CustomPokemonCardCell.swift
//  PokemonApiConsumer
//
//  Created by Izadora Matias on 08/02/24.
//

import UIKit

class CustomCellContent: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setConfigurations()
        return
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        return
    }
    
    public let label: UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.font = .preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    public let icon: UIImageView = {
        var icon = UIImageView()
        icon.image = UIImage(systemName: "chevron.right")
        icon.tintColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3)
        icon.translatesAutoresizingMaskIntoConstraints = false

        return icon
    }()
    
    private func setConfigurations() {
        self.setConstraints()
    }
    
    private func setConstraints() {
        addSubview(label)
        addSubview(icon)
        
        NSLayoutConstraint.activate([
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            
            icon.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            icon.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            icon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
    
    
}
