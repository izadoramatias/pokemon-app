//
//  DetailControllerDelegateMock.swift
//  PokemonApiConsumer
//
//  Created by Leonardo Leite on 08/03/24.
//

import Foundation

class DetailControllerDelegateMock: DetailControllerDelegate {
    var countOf_didGetCardImage: Int = 0
    var countOf_didEnterInLoadingCard = 0
    
    func didGetCardImage(data: Data) {
        countOf_didGetCardImage += 1
        return
    }
    
    func didEnterInLoadingCard() {
        countOf_didEnterInLoadingCard += 1
        return
    }
}
