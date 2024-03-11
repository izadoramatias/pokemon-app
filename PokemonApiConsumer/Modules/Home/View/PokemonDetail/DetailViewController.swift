//
//  DetailViewController.swift
//  PokemonApiConsumer
//
//  Created by Izadora Matias on 07/03/24.
//

import UIKit

class DetailViewController: UIViewController {
    public weak var presentationDelegate: PresentationDelegate?
    public var pokemonController = PokemonController()
    public var pokemonViewData: PokemonViewData? = nil
    let modalContentView: ModalContentView = {
        let contentView = ModalContentView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.backgroundColor = .systemBackground
        modalContentView.closeButton.addTarget(self, action: #selector(dismissModalPresentation), for: .touchUpInside)
        
        self.setConfigurations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.modalContentView.detailTitle.text = self.pokemonViewData?.name
        self.modalContentView.errorComponent.isHidden = true
    }
    
    private func setConfigurations() {
        self.setConstraints()
    }
    
    private func setConstraints() {
        self.view.addSubview(modalContentView)
        
        let safeAreaMargins = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.modalContentView.topAnchor.constraint(equalTo: safeAreaMargins.topAnchor),
            self.modalContentView.bottomAnchor.constraint(equalTo: safeAreaMargins.bottomAnchor),
            self.modalContentView.leadingAnchor.constraint(equalTo: safeAreaMargins.leadingAnchor),
            self.modalContentView.trailingAnchor.constraint(equalTo: safeAreaMargins.trailingAnchor),
        ])
    }
}

extension DetailViewController: DetailControllerDelegate {
    func didStopInError() {
        self.showErrorLabel()
        DispatchQueue.main.async {
            self.modalContentView.screenLoader.loadingIndicator.stopAnimating()
        }
    }
    
    func didEnterInLoadingCard() {
        self.modalContentView.card.cardImage.image = nil
        self.modalContentView.screenLoader.loadingIndicator.startAnimating()
    }

    func didGetCardImage(data: Data) {
        let image = self.generatePokemonImage(cardImageData: data)

        DispatchQueue.main.async {
            self.modalContentView.screenLoader.loadingIndicator.stopAnimating()
            self.modalContentView.card.cardImage.image = image
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
    
    private func showErrorLabel() {
        DispatchQueue.main.async {
            self.modalContentView.errorComponent.isHidden = false
        }
    }
}
