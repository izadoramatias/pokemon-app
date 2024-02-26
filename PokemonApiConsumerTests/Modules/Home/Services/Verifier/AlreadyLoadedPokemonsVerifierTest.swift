//
//  AlreadyLoadedPokemonsVerifierTest.swift
//  PokemonApiConsumerTests
//
//  Created by Izadora Matias on 19/02/24.
//

import XCTest
@testable import PokemonApiConsumer

final class AlreadyLoadedPokemonsVerifierTest: XCTestCase {
    private let pokemonsViewModelList: [PokemonViewModel] = [
        PokemonViewModel(id: "ap-1", imageData: Data()),
        PokemonViewModel(id: "pk-2", imageData: Data()),
        PokemonViewModel(id: "at-3", imageData: Data()),
    ]
    func test_isPokemonIsAlreadyRegistered_shouldNotifyPokemonIsRegistered_whenPokemonIsAlreadyRegistered() {
        
    }
    
    func testPokemonIsAlreadyRegistered() {
        let currentPokemon: PokemonDataModel.Pokemon = PokemonDataModel.Pokemon(
            id: "ap-1",
            name: "Ampharos",
            images: PokemonDataModel.ImagesStringUrl(small: "")
        )
        
        let isRegistered = isPokemonAlreadyRegistered(currentPokemon: currentPokemon)
        
        XCTAssertTrue(isRegistered)
    }
    
    func testPokemonIsNotRegisteredYet() {
        let currentPokemon: PokemonDataModel.Pokemon = PokemonDataModel.Pokemon(id: "ch-1", name: "Charmander", images: PokemonDataModel.ImagesStringUrl(small: ""))
        
        let isRegistered = isPokemonAlreadyRegistered(currentPokemon: currentPokemon)
        
        XCTAssertFalse(isRegistered)
    }
    
}

extension AlreadyLoadedPokemonsVerifierTest {
    private func isPokemonAlreadyRegistered(currentPokemon: PokemonDataModel.Pokemon) -> Bool {
        let verifier = AlreadyLoadedPokemonsVerifier()
        
        let result: Bool = verifier.isPokemonIsAlreadyRegistered(currentPokemon: currentPokemon, pokemonsList: self.pokemonsViewModelList)
        
        return result
    }
}
