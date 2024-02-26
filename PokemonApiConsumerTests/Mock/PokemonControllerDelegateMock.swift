//
//  PokemonControllerDelegateMock.swift
//  PokemonApiConsumer
//
//  Created by Izadora Matias on 05/03/24.
//

import Foundation

class PokemonControllerDelegateMock: PokemonControllerDelegate {
    var countOf_didEnterInLoading: Int = 0
    var countOf_didGetPokemonsViewDataList: Int = 0
    var countOf_didStopInError: Int = 0

    func didStopInError() {
        self.countOf_didStopInError += 1
        return
    }

    func didGetPokemonsViewDataList(data: [PokemonViewData]) {
        self.countOf_didGetPokemonsViewDataList += 1
        return
    }

    func didEnterInLoading() {
        self.countOf_didEnterInLoading += 1
        return
    }
}
