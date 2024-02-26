//
//  PokemonController.swift
//  PokemonApiConsumer
//
//  Created by Izadora Matias on 01/02/24.
//

import Foundation

class PokemonController {
    public weak var delegate: PokemonControllerDelegate?
    public weak var detailDelegate: DetailControllerDelegate?
    private let pokemonsDataModelListLoader: PokemonsDataLoader
    private let pokemonsFinder: PokemonsFinder
    private let converter: PokemonDataConverter
    
    init(
        delegate: PokemonControllerDelegate? = nil,
        detailDelegate: DetailControllerDelegate? = nil,
        pokemonsDataModelListLoader: PokemonsDataLoader = PokemonsDataLoader(),
        pokemonsFinder: PokemonsFinder = PokemonsFinder(),
        converter: PokemonDataConverter = PokemonDataConverter()
    ) {
        self.delegate = delegate
        self.detailDelegate = detailDelegate
        self.pokemonsDataModelListLoader = pokemonsDataModelListLoader
        self.pokemonsFinder = pokemonsFinder
        self.converter = converter
    }
    
    private func getPokemonsViewDataList(currentPokemonsList: [PokemonViewData], totalPokemons: Int = 0, totalPokemonsPerPage: Int = 30, completion: @escaping ([PokemonViewData]?) -> Void) {
            
        pokemonsDataModelListLoader.loadPokemonsDataModelList(totalPokemonsPerPage: totalPokemonsPerPage, currentPage: self.offsetCalculate(totalPokemons: totalPokemons, totalPokemonsPerPage: totalPokemonsPerPage)) { pokemonsViewDataModelList in
            
            if let pokemonsViewDataModelList = pokemonsViewDataModelList {
                completion(self.pokemonsFinder.findPokemonsNotRegisteredYed(pokemonDataModel: pokemonsViewDataModelList, currentPokemonList: currentPokemonsList))
                return
            }
            completion(nil)
        }
    }
    
    public func loadPokemons(currentPokemonsList: [PokemonViewData]) {
        self.delegate?.didEnterInLoading()
        
        self.getPokemonsViewDataList(currentPokemonsList: currentPokemonsList, totalPokemons: currentPokemonsList.count) { pokemonsViewDataList in
            guard let pokemonsViewDataList = pokemonsViewDataList else {
                self.delegate?.didStopInError()
                return
            }

            self.delegate?.didGetPokemonsViewDataList(data: pokemonsViewDataList)
        }
    }
    
    private func getCard(cardId: String, completion: @escaping (Data?) -> Void) -> Void {
        self.pokemonsDataModelListLoader.loadPokemonCardModel(cardId: cardId) { pokemonCardModel in
            let url = self.converter.convertToUrl(cardModel: pokemonCardModel)
            let data = self.converter.convertToData(cardUrl: url)
            
            completion(data)
        }
    }
    
    public func loadCardImage(pokemonId: String) {
        self.detailDelegate?.didEnterInLoadingCard()
        
        self.getCard(cardId: pokemonId) { data in
            guard let cardData = data else {
                self.delegate?.didStopInError()
                return
            }
            self.detailDelegate?.didGetCardImage(data: cardData)
        }
    }

    private func offsetCalculate(totalPokemons: Int, totalPokemonsPerPage: Int) -> Int {
        return (totalPokemons / totalPokemonsPerPage) + 1
    }
}
