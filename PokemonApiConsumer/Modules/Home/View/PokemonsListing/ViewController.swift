//
//  ViewController.swift
//  PokemonApiConsumer
//
//  Created by Izadora Matias on 30/01/24.
//

import UIKit

class ViewController: UIViewController {
    
    var pokemonController = PokemonController()
    var pokemonsViewDataList = [PokemonViewData]()
    let pokemonsListingContentView: PokemonsListingContentView = {
       let contentView = PokemonsListingContentView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        return contentView
    }()
    let detailVC = DetailViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.setConfigurations()
                        
        self.pokemonController.delegate = self
        self.pokemonController.detailDelegate = detailVC
        self.detailVC.presentationDelegate = self
        self.pokemonsListingContentView.pokemonTableView.tableView.delegate = self
        self.pokemonsListingContentView.pokemonTableView.tableView.dataSource = self
        self.pokemonsListingContentView.pokemonTableView.tableView.register(CustomCellPokemonPaginationButton.self, forCellReuseIdentifier: "pokemonPaginationButton")
        self.pokemonsListingContentView.pokemonTableView.tableView.register(CustomCellContent.self, forCellReuseIdentifier: "customCellContent")
        self.pokemonsListingContentView.pokemonTableView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        self.pokemonController.loadPokemons(currentPokemonsList: self.pokemonsViewDataList)
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
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pokemonsViewDataList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let canLoadMoreItems = indexPath.row == self.pokemonsViewDataList.count - 5
        
        if canLoadMoreItems {
            let debouncer = Debouncer(delay: 0.8)
            debouncer.debounce {
                self.pokemonController.loadPokemons(currentPokemonsList: self.pokemonsViewDataList)
            }
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: "customCellContent", for: indexPath) as! CustomCellContent
        
        let isPokemonsLoaded = !self.pokemonsViewDataList.isEmpty
        if ( isPokemonsLoaded ) {
            let name = self.pokemonsViewDataList[indexPath.row].name
            let id = self.pokemonsViewDataList[indexPath.row].id
            cell.label.text = "\(name) - \(id)"
            if ( indexPath.row % 2 == 0 ) {
                cell.backgroundColor = UIColor(red: 232/255, green: 232/255, blue: 232/255, alpha: 0.8)
            }
            else {
               cell.backgroundColor = .white
           }
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let isLastItem = (self.pokemonsViewDataList.count != 0 && indexPath.row == self.pokemonsViewDataList.count)
        
        if ( isLastItem ) {
            return
        }
        
        let cardId = self.pokemonsViewDataList[indexPath.row].id
        self.pokemonController.loadCardImage(pokemonId: cardId)
        self.detailVC.pokemonViewData = self.pokemonsViewDataList[indexPath.row]
        self.navigationController?.present(detailVC, animated: true)
    }
}

extension ViewController: PokemonControllerDelegate {
    func didStopInError() {
        self.showMessage()
        DispatchQueue.main.async {
            self.pokemonsListingContentView.screenLoader.loadingIndicator.stopAnimating()
        }
    }
    
    func didEnterInLoading() {
        self.hideButton()
        self.pokemonsListingContentView.screenLoader.loadingIndicator.startAnimating()
    }

    func didGetPokemonsViewDataList(data: [PokemonViewData]) {
        DispatchQueue.main.async {
            self.pokemonsListingContentView.screenLoader.loadingIndicator.stopAnimating()
        }

        if data.isEmpty { return }

        self.pokemonsViewDataList.append(contentsOf: data)
        
        self.showButton()
        DispatchQueue.main.async {
            self.pokemonsListingContentView.pokemonTableView.tableView.reloadData()
        }
    }
}

extension ViewController: PresentationDelegate {
    func didDismissDetailView() {
        self.navigationController?.dismiss(animated: true)
    }
}

extension ViewController {
    @objc func loadPokemons() {
        self.pokemonController.loadPokemons(currentPokemonsList: self.pokemonsViewDataList)
    }
}

extension ViewController {
    private func generatePokemonImage(cardImageData: Data) -> UIImage {
        guard let pokemonImage = UIImage(data: cardImageData) else { return UIImage() }
        return pokemonImage
    }
    
    private func hideButton() {
        DispatchQueue.main.async {
            let buttonCell = self.pokemonsListingContentView.pokemonTableView.tableView.cellForRow(at: IndexPath(row: self.pokemonsViewDataList.count, section: 0))
            buttonCell?.isHidden = true
        }
    }
    
    private func showButton() {
        DispatchQueue.main.async {
            let buttonCell = self.pokemonsListingContentView.pokemonTableView.tableView.cellForRow(at: IndexPath(row: self.pokemonsViewDataList.count, section: 0))
            buttonCell?.isHidden = false
        }
    }
    
    private func showMessage() {
        print("aqui")
    }
}