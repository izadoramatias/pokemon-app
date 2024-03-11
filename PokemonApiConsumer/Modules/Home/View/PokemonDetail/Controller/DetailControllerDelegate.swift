//
//  DetailControllerDelegate.swift
//  PokemonApiConsumer
//
//  Created by Izadora Matias on 07/03/24.
//

import Foundation

protocol DetailControllerDelegate: AnyObject {
    func didGetCardImage(data: Data)
    func didEnterInLoadingCard()
    func didStopInError()
}
