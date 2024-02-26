//
//  PokemonDataConverter.swift
//  PokemonApiConsumer
//
//  Created by Izadora Matias on 01/03/24.
//

import Foundation

class PokemonDataConverter {
    public func convertToUrl(cardModel: PokemonCardModel?) -> URL? {
        guard let pokemonCardModel = cardModel else { return nil }
        guard let url = URL(string: pokemonCardModel.data.images.large) else { return nil }
        
        return url
    }
    
    public func convertToData(cardUrl: URL?) -> Data? {
        guard let url = cardUrl else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        
        return data
    }
}
