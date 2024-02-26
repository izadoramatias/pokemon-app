//
//  PokemonControllerDelegate.swift
//  PokemonApiConsumer
//
//  Created by Izadora Matias on 01/02/24.
//

import UIKit

protocol PokemonControllerDelegate: AnyObject {
    func didGetPokemonsViewDataList(data: [PokemonViewData])
    func didEnterInLoading()
    func didStopInError()
}
