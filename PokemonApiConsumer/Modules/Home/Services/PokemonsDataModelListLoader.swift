//
//  generatePokemonsList.swift
//  PokemonApiConsumer
//
//  Created by Izadora Matias on 31/01/24.


import Foundation

class PokemonsDataModelListLoader {
    var pokemonsRepository: PokemonsRepository

    init(pokemonsRepository: PokemonsRepository) {
        self.pokemonsRepository = pokemonsRepository
    }

    public func loadPokemonsDataModelList(completion: @escaping (PokemonDataModel) -> Void, totalPokemonsPerPage: Int, currentPage: Int ) -> Void {

        self.pokemonsRepository.getPokemons(completion: { (pokemonsDataModel) in

            if let unwrappedPokemonDataModel = pokemonsDataModel {
                return completion(unwrappedPokemonDataModel)
            }
            
            completion(PokemonDataModel(data: []))
        }, totalPokemonsPerPage: totalPokemonsPerPage, page: currentPage)
    }
}
