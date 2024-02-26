//
//  GeneratePokemonsImageList.swift
//  PokemonApiConsumer
//
//  Created by Izadora Matias on 08/02/24.
//

import Foundation

class PokemonsListsGenerator {
    private let alreadyLoadedPokemonsVerifier = AlreadyLoadedPokemonsVerifier()
    
    func pokemonCollectionGenerate(pokemonsDataModel: PokemonDataModel, currentListLoadedPokemons: [PokemonViewModel]) -> [[String: Any]] {
        var pokemonCollection: [[String: Any]] = []
        
        for pokemon in pokemonsDataModel.data {
            let isPokemonsListEmpty = currentListLoadedPokemons.isEmpty
            let isNotPokemonAlreadyRegistered = !self.alreadyLoadedPokemonsVerifier.isPokemonIsAlreadyRegistered(currentPokemon: pokemon, pokemonsList: currentListLoadedPokemons)

            if ( isPokemonsListEmpty || isNotPokemonAlreadyRegistered ) {
                let stringUrl = pokemon.images.small
                guard let url = URL(string: stringUrl) else { continue }
                
                pokemonCollection.append([
                    "id": pokemon.id,
                    "imageUrl": url
                ])
            }
        }

        return pokemonCollection
    }
    
    public func pokemonsViewModelGenerate(pokemonCollection: [[String: Any]]) -> [PokemonViewModel] {
        var pokemonsViewModelList = [PokemonViewModel]()

        for pokemon in pokemonCollection {
            if let data = try? Data(contentsOf: pokemon["imageUrl"] as! URL) {
                pokemonsViewModelList.append(PokemonViewModel(id: pokemon["id"] as! String, imageData: data))
            }
        }

        return pokemonsViewModelList
    }
}
