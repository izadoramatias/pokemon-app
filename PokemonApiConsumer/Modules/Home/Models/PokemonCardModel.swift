//
//  PokemonCardModel.swift
//  PokemonApiConsumer
//
//  Created by Izadora Matias on 01/03/24.
//

import Foundation

struct PokemonCardModel: Decodable, Equatable {
    var data: Card
    
    struct Card: Decodable, Equatable {
        var images: Images
    }
    
    struct Images: Decodable, Equatable {
        var large: String
    }
    
}
