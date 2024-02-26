//
//  DetailViewController.swift
//  PokemonApiConsumer
//
//  Created by Izadora Matias on 07/03/24.
//

import UIKit

class DetailViewController: UIViewController {
    public weak var presentationDelegate: PresentationDelegate?
    public var pokemonCardModal: PokemonCardModal = {
        let modal = PokemonCardModal()
        modal.translatesAutoresizingMaskIntoConstraints = false
                
        return modal
    }()
    public var pokemonController = PokemonController()
    public var pokemonViewData: PokemonViewData? = nil
    
    let closeButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(systemName: "multiply.circle.fill"), for: .normal)
        button.tintColor = .lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    public var detailTitle: UILabel = {
       var title = UILabel()
        title.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.8)
        title.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        title.lineBreakMode = NSLineBreakMode.byWordWrapping
        title.translatesAutoresizingMaskIntoConstraints = false
        
        return title
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.backgroundColor = .systemBackground
        closeButton.addTarget(self, action: #selector(dismissModalPresentation), for: .touchUpInside)
        
        self.setConfigurations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.detailTitle.text = self.pokemonViewData?.name
    }
    
    private func setConfigurations() {
        self.setConstraints()
    }
    
    private func setConstraints() {
        self.view.addSubview(pokemonCardModal)
        self.view.addSubview(closeButton)
        self.view.addSubview(detailTitle)
        let safeAreaMargins = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            pokemonCardModal.topAnchor.constraint(equalTo: safeAreaMargins.topAnchor),
            pokemonCardModal.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            pokemonCardModal.trailingAnchor.constraint(equalTo: safeAreaMargins.trailingAnchor),
            pokemonCardModal.leadingAnchor.constraint(equalTo: safeAreaMargins.leadingAnchor),
            
            self.closeButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            self.closeButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30),
            
            self.detailTitle.topAnchor.constraint(equalTo: self.closeButton.topAnchor),
            self.detailTitle.leadingAnchor.constraint(equalTo: safeAreaMargins.leadingAnchor, constant: 10),
        ])
    }
}

extension DetailViewController: DetailControllerDelegate {
    func didEnterInLoadingCard() {
        self.pokemonCardModal.cardImage.image = nil
        self.pokemonCardModal.screenLoader.loadingIndicator.startAnimating()
    }

    func didGetCardImage(data: Data) {
        let image = self.generatePokemonImage(cardImageData: data)

        DispatchQueue.main.async {
            self.pokemonCardModal.screenLoader.loadingIndicator.stopAnimating()
            self.pokemonCardModal.cardImage.image = image
        }
    }
}

extension DetailViewController {
    @objc func dismissModalPresentation() {
        self.presentationDelegate?.didDismissDetailView()
    }
}

extension DetailViewController {
    private func generatePokemonImage(cardImageData: Data) -> UIImage {
        guard let pokemonImage = UIImage(data: cardImageData) else { return UIImage() }
        return pokemonImage
    }
}
