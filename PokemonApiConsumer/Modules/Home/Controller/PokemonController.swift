//
//  PokemonController.swift
//  PokemonApiConsumer
//
//  Created by Izadora Matias on 01/02/24.
//

import Foundation

class PokemonController {
    public weak var delegate: PokemonControllerDelegate?
    private let pokemonsDataModelListLoader = PokemonsDataModelListLoader(pokemonsRepository: PokemonsRepository())
    private let pokemonsListsGenerator = PokemonsListsGenerator()
    private var totalPokemons: Int = 0
    private var totalPokemonsPerPage = 3
    private var currentPokemonsList: [PokemonViewModel] = []
    
    private func getPokemonsUrl(completion: @escaping ([[String: Any]]) -> Void) {
        pokemonsDataModelListLoader.loadPokemonsDataModelList(completion: { pokemonsDataModel in
            let pokemonCollection = self.pokemonsListsGenerator.pokemonCollectionGenerate(pokemonsDataModel: pokemonsDataModel, currentListLoadedPokemons: self.currentPokemonsList)
            
            completion(pokemonCollection)
        }, totalPokemonsPerPage: self.totalPokemonsPerPage, currentPage: self.offsetCalculate())
    }

    public func loadPokemons() {
        self.delegate?.didEnterInLoading()
        
        self.getPokemonsUrl { pokemonCollection in
            let pokemonsViewModelList = self.pokemonsListsGenerator.pokemonsViewModelGenerate(pokemonCollection: pokemonCollection)

            self.delegate?.didGetPokemonsViewModelList(data: pokemonsViewModelList)
        }
    }

    private func offsetCalculate() -> Int {
        return (self.totalPokemons / self.totalPokemonsPerPage) + 1
    }
    
    public func setTotalPokemons(totalPokemons: Int) {
        self.totalPokemons = totalPokemons
    }
}
