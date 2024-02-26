//
//  PokemonsDataModelListLoaderMock.swift
//  PokemonApiConsumer
//
//  Created by Izadora Matias on 05/03/24.
//

import Foundation

class PokemonsDataLoaderMock: PokemonsDataLoader {
    var resultOf_LoadPokemonsDataModelList: PokemonDataModel?
    var resultOf_LoadPokemonCardModel: PokemonCardModel?
    
    override func loadPokemonsDataModelList(totalPokemonsPerPage: Int, currentPage: Int, completion: @escaping (PokemonDataModel?) -> Void) {
        let pokemonsDataModel = resultOf_LoadPokemonsDataModelList
        completion(pokemonsDataModel)
    }
    
    override func loadPokemonCardModel(cardId: String, completion: @escaping (PokemonCardModel?) -> Void) {
        let pokemonCardModel = resultOf_LoadPokemonCardModel
        completion(pokemonCardModel)
    }
}
