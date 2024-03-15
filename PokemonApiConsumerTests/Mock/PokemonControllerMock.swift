//
//  PokemonControllerMock.swift
//  PokemonApiConsumer
//
//  Created by Leonardo Leite on 13/03/24.
//

import Foundation

class PokemonControllerMock: PokemonController {
    public var cardData: Data? = nil
    
    override func loadPokemons(currentPokemonsList: [PokemonViewData]) {
        delegate?.didGetPokemonsViewDataList(data: currentPokemonsList)
    }
    
    override func loadCardImage(pokemonId: String) {
        detailDelegate?.didGetCardImage(data: cardData!)
    }
}
