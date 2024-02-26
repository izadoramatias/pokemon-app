//
//  PokemonsListsGeneratorMock.swift
//  PokemonApiConsumer
//
//  Created by Izadora Matias on 05/03/24.
//

import Foundation

class PokemonsFinderMock: PokemonsFinder {
    override func findPokemonsNotRegisteredYed(pokemonDataModel: PokemonDataModel?, currentPokemonList: [PokemonViewData]) -> [PokemonViewData] {
        let pokemonCollection = [PokemonViewData]()

        return pokemonCollection

    }
}

