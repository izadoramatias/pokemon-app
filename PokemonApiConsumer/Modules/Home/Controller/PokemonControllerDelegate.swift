//
//  PokemonControllerDelegate.swift
//  PokemonApiConsumer
//
//  Created by Izadora Matias on 01/02/24.
//

import UIKit

protocol PokemonControllerDelegate: AnyObject {
    func didGetPokemonsViewModelList(data: [PokemonViewModel])
    func didEnterInLoading()
}
