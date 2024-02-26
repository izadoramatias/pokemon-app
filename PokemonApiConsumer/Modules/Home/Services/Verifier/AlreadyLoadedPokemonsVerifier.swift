//
//  AlreadyLoadedPokemonsVerifier.swift
//  PokemonApiConsumer
//
//  Created by Izadora Matias on 19/02/24.
//

import Foundation

class AlreadyLoadedPokemonsVerifier {
    public func isPokemonIsAlreadyRegistered(currentPokemon: PokemonDataModel.Pokemon, pokemonsList: [PokemonViewModel]) -> Bool {
        var isPokemonAlreadyRegistered = false

        for pokemon in pokemonsList {
            if ( pokemon.id == currentPokemon.id ) {
                isPokemonAlreadyRegistered = true
                return isPokemonAlreadyRegistered
            }
        }
        return isPokemonAlreadyRegistered
    }}
