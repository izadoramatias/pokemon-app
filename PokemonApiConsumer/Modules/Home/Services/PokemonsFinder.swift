//
//  GeneratePokemonsImageList.swift
//  PokemonApiConsumer
//
//  Created by Izadora Matias on 08/02/24.
//

import Foundation

class PokemonsFinder {
    private let alreadyLoadedPokemonsVerifier = AlreadyLoadedPokemonsVerifier()
    
    public func findPokemonsNotRegisteredYed(pokemonDataModel: PokemonDataModel?, currentPokemonList: [PokemonViewData]) -> [PokemonViewData] {
        var pokemonsViewDataList = [PokemonViewData]()

        if let pokemons = pokemonDataModel?.data {
            for pokemon in pokemons {
                let isNotPokemonAlreadyRegistered: Bool = !self.alreadyLoadedPokemonsVerifier.isPokemonAlreadyRegistered(currentPokemon: pokemon, pokemonsList: currentPokemonList)
                
                if isNotPokemonAlreadyRegistered { pokemonsViewDataList.append(PokemonViewData(id: pokemon.id, name: pokemon.name)) }                
            }
        }

        return pokemonsViewDataList
    }
}
