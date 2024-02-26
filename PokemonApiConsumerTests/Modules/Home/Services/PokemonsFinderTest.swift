//
//  PokemonsUrlListLoaderTest.swift
//  PokemonApiConsumerTests
//
//  Created by Izadora Matias on 19/02/24.
//

import XCTest
@testable import PokemonApiConsumer
import UIKit

final class PokemonsFinderTest: XCTestCase {
    func testShouldFindANotAlreadyRegisteredPokemon() {
        let pokemonToInsertMock = PokemonDataModel(data: [PokemonDataModel.Pokemon(id: "ap-1", name: "Ampharos")])
        let listOf_AlreadyExistingPokemonsMock = [PokemonViewData(id: "ch-1", name: "pokemon 1")]
        let sut = PokemonsFinder()
        
        let result: [PokemonViewData] = sut.findPokemonsNotRegisteredYed(pokemonDataModel: pokemonToInsertMock, currentPokemonList: listOf_AlreadyExistingPokemonsMock)
                
        XCTAssertEqual(1, result.count)
        XCTAssertEqual("ap-1", result[0].id)
        XCTAssertEqual("Ampharos", result[0].name)
    }
    
    func testShouldFindANotAlreadyRegisteredPokemonWhenListOfExistingPokemonsIsEmpty() {
        let pokemonToInsertMock = PokemonDataModel(data: [PokemonDataModel.Pokemon(id: "ap-1", name: "Ampharos")])
        let listOf_AlreadyExistingPokemonsMock = [PokemonViewData]()
        let sut = PokemonsFinder()
        
        let result: [PokemonViewData] = sut.findPokemonsNotRegisteredYed(pokemonDataModel: pokemonToInsertMock, currentPokemonList: listOf_AlreadyExistingPokemonsMock)

        XCTAssertEqual(1, result.count)
        XCTAssertEqual("ap-1", result[0].id)
        XCTAssertEqual("Ampharos", result[0].name)
    }

    func testShouldNotFindANotAlreadyRegisteredPokemon() {
        let pokemonToInsertMock = PokemonDataModel(data: [PokemonDataModel.Pokemon(id: "ap-1", name: "Ampharos")])
        let listOf_AlreadyExistingPokemonsMock = [PokemonViewData(id: "ap-1", name: "Ampharos")]
        let sut = PokemonsFinder()

        let result: [PokemonViewData] = sut.findPokemonsNotRegisteredYed(pokemonDataModel: pokemonToInsertMock, currentPokemonList: listOf_AlreadyExistingPokemonsMock)

        XCTAssertTrue(result.isEmpty)
    }
}
