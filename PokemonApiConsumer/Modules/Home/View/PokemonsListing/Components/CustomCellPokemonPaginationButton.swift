//
//  PokemonsPagination.swift
//  PokemonApiConsumer
//
//  Created by Izadora Matias on 05/02/24.
//

import UIKit

class CustomCellPokemonPaginationButton: UITableViewCell {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setConfiguration()

        return
    }
    
    public let loadMoreItensButton: UIButton = {
        let loadMore = UIButton()
        loadMore.setTitle("Carregar mais pokemons", for: .normal)
        loadMore.setTitleColor(.systemBlue, for: .normal)
        loadMore.contentVerticalAlignment = .center
        loadMore.contentHorizontalAlignment = .center
        loadMore.layer.borderWidth = 1.5
        loadMore.layer.cornerRadius = 4
        loadMore.layer.borderColor = UIColor.systemBlue.cgColor
        loadMore.translatesAutoresizingMaskIntoConstraints = false

        return loadMore
    }()
    
    private func setConfiguration() {
        self.setConstraints()
    }

    private func setConstraints() {
        contentView.addSubview(loadMoreItensButton)

        NSLayoutConstraint.activate([
            loadMoreItensButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            loadMoreItensButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
//            loadMoreItensButton.topAnchor.constraint(equalTo: topAnchor, constant: 15),
//            loadMoreItensButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),

            contentView.topAnchor.constraint(equalTo: loadMoreItensButton.topAnchor, constant: -20),
            contentView.bottomAnchor.constraint(equalTo: loadMoreItensButton.bottomAnchor, constant: 20),
        ])
    }

}
