//
//  generatePokemonsList.swift
//  PokemonApiConsumer
//
//  Created by Izadora Matias on 31/01/24.


import Foundation

class PokemonsDataLoader {
    var pokemonsRepository: PokemonsRepository

    init(pokemonsRepository: PokemonsRepository = .init()) {
        self.pokemonsRepository = pokemonsRepository
    }

    public func loadPokemonsDataModelList(totalPokemonsPerPage: Int, currentPage: Int, completion: @escaping (PokemonDataModel?) -> Void) -> Void {
        self.pokemonsRepository.getPokemons(totalPokemonsPerPage: totalPokemonsPerPage, page: currentPage) { result in
            switch result {
            case .success(let pokemonsDataModel):
                if let pokemonsDataModel = pokemonsDataModel {
                    completion(pokemonsDataModel)
                    return
                }
                
                completion(nil)
                return
            case .failure(_):
                completion(nil)
                return
            }
        }
    }
    
    public func loadPokemonCardModel(cardId: String, completion: @escaping (PokemonCardModel?) -> Void) -> Void {
        self.pokemonsRepository.getCard(cardId: cardId) { result in
            switch result {
            case .success(let pokemonCardModel):
                if let pokemonCardModel = pokemonCardModel {
                    completion(pokemonCardModel)
                    return
                }
                completion(nil)
                return
            case .failure(_):
                completion(nil)
                return
            }
        }
    }
}
