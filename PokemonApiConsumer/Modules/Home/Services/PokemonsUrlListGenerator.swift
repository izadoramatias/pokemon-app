//
//  PokemonsUrlListGenerator.swift
//  PokemonApiConsumer
//
//  Created by Leonardo Leite on 20/02/24.
//

import Foundation

class PokemonsUrlListGenerator {
    private var completePokemonsList = [PokemonDataModel.Pokemon]()
    private let alreadyLoadedPokemonsVerifier = AlreadyLoadedPokemonsVerifier()

    func urlListGenerate(pokemonsDataModelList: PokemonDataModel) -> [URL] {
        var pokemonsImagesUrlList = [URL]()
        
        for pokemon in pokemonsDataModelList.data {
            let isPokemonsListEmpty = self.completePokemonsList.isEmpty
            let isNotPokemonAlreadyRegistered = !self.alreadyLoadedPokemonsVerifier.isPokemonIsAlreadyRegistered(currentPokemon: pokemon, pokemonsList: self.completePokemonsList)

            if ( isPokemonsListEmpty || isNotPokemonAlreadyRegistered ) {
                let stringUrl = pokemon.images.small
                guard let url = URL(string: stringUrl) else { continue }

                pokemonsImagesUrlList.append(url)
                self.completePokemonsList.append(pokemon)
            }
        }

        return pokemonsImagesUrlList
    }
}
