//
//  PokemonDataModel.swift
//  PokemonApiConsumer
//
//  Created by Izadora Matias on 30/01/24.
//

import Foundation

struct PokemonDataModel: Decodable {
    var data: Array<Pokemon>
    
    struct Pokemon: Decodable {
        var id: String
        var name: String
        var images: ImagesStringUrl
    }
    
    struct ImagesStringUrl: Decodable {
        var small: String
//        var large: String
    }
}
