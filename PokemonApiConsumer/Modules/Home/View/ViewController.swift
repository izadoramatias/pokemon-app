//
//  ViewController.swift
//  PokemonApiConsumer
//
//  Created by Izadora Matias on 30/01/24.
//

import UIKit

class ViewController: UIViewController {
    
    var pokemonController = PokemonController()
    var pokemonsImages = [UIImage]()
    let pokemonsListingContentView: PokemonsListingContentView = {
       let contentView = PokemonsListingContentView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        return contentView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.setConfigurations()
                        
        self.pokemonController.delegate = self
        self.pokemonsListingContentView.pokemonTableView.tableView.delegate = self
        self.pokemonsListingContentView.pokemonTableView.tableView.dataSource = self
        self.pokemonsListingContentView.pokemonTableView.tableView.register(CustomCellPokemonPaginationButton.self, forCellReuseIdentifier: "pokemonPaginationButton")
        self.pokemonsListingContentView.pokemonTableView.tableView.register(CustomPokemonCardCell.self, forCellReuseIdentifier: "pokemonCard")

        self.pokemonController.loadPokemons()
    }
    
    private func setConfigurations() {
        self.setConstraints()
    }
    
    private func setConstraints() {
        self.view.addSubview(self.pokemonsListingContentView)
                
        let safeAreaMargins = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            self.pokemonsListingContentView.topAnchor.constraint(equalTo: safeAreaMargins.topAnchor),
            self.pokemonsListingContentView.bottomAnchor.constraint(equalTo: safeAreaMargins.bottomAnchor),
            self.pokemonsListingContentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.pokemonsListingContentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
        ])
    }
    
    private func generatePokemonsImage(pokemonsImagesData: [PokemonViewModel]) -> [UIImage] {
        var images = [UIImage]()
        
        for pokemonImageData in pokemonsImagesData {
            guard let pokemonImage = UIImage(data: pokemonImageData.imageData) else { return [] }
            images.append(pokemonImage)
        }
        
        return images
    }
    
    private func hideButton() {
        DispatchQueue.main.async {
            let buttonCell = self.pokemonsListingContentView.pokemonTableView.tableView.cellForRow(at: IndexPath(row: self.pokemonsImages.count, section: 0))
            buttonCell?.isHidden = true
        }
    }

    private func showButton() {
        DispatchQueue.main.async {
            let buttonCell = self.pokemonsListingContentView.pokemonTableView.tableView.cellForRow(at: IndexPath(row: self.pokemonsImages.count, section: 0))
            buttonCell?.isHidden = false
        }
    }
}
// MARK: clebinho
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pokemonsImages.count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let isTableLastItem = self.pokemonsImages.count != 0 && indexPath.row == self.pokemonsImages.count
        if ( isTableLastItem ) {
            let customPaginatorButtonCell = tableView.dequeueReusableCell(withIdentifier: "pokemonPaginationButton", for: indexPath) as? CustomCellPokemonPaginationButton
            customPaginatorButtonCell?.selectionStyle = .none
            customPaginatorButtonCell?.loadMoreItensButton.addTarget(self, action: #selector(self.loadPokemons), for: .touchUpInside)
            
            return customPaginatorButtonCell!
        }

        let customPokemonCardCell = tableView.dequeueReusableCell(withIdentifier: "pokemonCard", for: indexPath) as! CustomPokemonCardCell
        let isThereLoadedImages = self.pokemonsImages != []
        if ( isThereLoadedImages ) {
            customPokemonCardCell.imgView.image = self.pokemonsImages[indexPath.row]
        }

        return customPokemonCardCell
    }
    
    @objc func loadPokemons() {
        self.pokemonController.loadPokemons()
    }
}

extension ViewController: PokemonControllerDelegate {
    func didEnterInLoading() {
        self.hideButton()
        self.pokemonController.setTotalPokemons(totalPokemons: self.pokemonsImages.count)
        self.pokemonsListingContentView.screenLoader.loadingIndicator.startAnimating()
    }

    func didGetPokemonsViewModelList(data: [PokemonViewModel]) {
        DispatchQueue.main.async {
            self.pokemonsListingContentView.screenLoader.loadingIndicator.stopAnimating()
        }

        if data.isEmpty { return }

        let pokemonsImages = self.generatePokemonsImage(pokemonsImagesData: data)
        self.pokemonsImages.append(contentsOf: pokemonsImages)
        
        self.showButton()
        DispatchQueue.main.async {
            self.pokemonsListingContentView.pokemonTableView.tableView.reloadData()
        }
    }
}
