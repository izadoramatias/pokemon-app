//
//  AlreadyLoadedPokemonsVerifierTest.swift
//  PokemonApiConsumerTests
//
//  Created by Izadora Matias on 19/02/24.
//

import XCTest
@testable import PokemonApiConsumer

final class AlreadyLoadedPokemonsVerifierTest: XCTestCase {
    func testShouldNotifyPokemonIsAlreadyRegistered() {
        let listOf_AlreadyExistingPokemons: [PokemonViewData] = [
            PokemonViewData(id: "ap-1", name: "pokemon 1"),
            PokemonViewData(id: "pk-2", name: "pokemon 2"),
            PokemonViewData(id: "at-3", name: "pokemon 3"),
        ]
        let pokemonToInsert: PokemonDataModel.Pokemon = PokemonDataModel.Pokemon(id: "ap-1", name: "Ampharos")
        let sut = AlreadyLoadedPokemonsVerifier()
        
        let result: Bool = sut.isPokemonAlreadyRegistered(currentPokemon: pokemonToInsert, pokemonsList: listOf_AlreadyExistingPokemons)
        
        XCTAssertTrue(result)
    }
    
    func testShouldNotifyPokemonIsNotRegisteredYet() {
        let listOf_AlreadyExistingPokemons: [PokemonViewData] = [
            PokemonViewData(id: "ap-1", name: "pokemon 1"),
            PokemonViewData(id: "pk-2", name: "pokemon 2"),
            PokemonViewData(id: "at-3", name: "pokemon 3"),
        ]
        let pokemonToInsert: PokemonDataModel.Pokemon = PokemonDataModel.Pokemon(id: "ch-1", name: "Charmander")
        let sut = AlreadyLoadedPokemonsVerifier()


        let result: Bool = sut.isPokemonAlreadyRegistered(currentPokemon: pokemonToInsert, pokemonsList: listOf_AlreadyExistingPokemons)

        XCTAssertFalse(result)
    }
}
