//
//  PokemonsRepositoryMock.swift
//  PokemonApiConsumer
//
//  Created by Izadora Matias on 04/03/24.
//

import Foundation

class PokemonsRepositoryMock: PokemonsRepository {
    var returnOf_getPokemons: Result<PokemonDataModel?, Errors>?
    var returnOf_getCard: Result<PokemonCardModel?, Errors>?
    
    override func getPokemons(totalPokemonsPerPage: Int, page: Int, completion: @escaping (Result<PokemonDataModel?, Errors>) -> Void) {
        completion(returnOf_getPokemons!)
    }
    
    override func getCard(cardId: String, completion: @escaping (Result<PokemonCardModel?, Errors>) -> Void) {
        completion(returnOf_getCard!)
    }
}
