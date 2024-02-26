//
//  PokemonDataModel.swift
//  PokemonApiConsumer
//
//  Created by Izadora Matias on 30/01/24.
//

import Foundation

struct PokemonDataModel: Decodable, Equatable {
    var data: Array<Pokemon>
    
    struct Pokemon: Decodable, Equatable {
        var id: String
        var name: String
    }
}
