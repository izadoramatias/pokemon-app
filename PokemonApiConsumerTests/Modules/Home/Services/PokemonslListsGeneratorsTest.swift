//
//  PokemonsUrlListLoaderTest.swift
//  PokemonApiConsumerTests
//
//  Created by Izadora Matias on 19/02/24.
//

import XCTest
@testable import PokemonApiConsumer
import UIKit

final class PokemonslListsGeneratorsTest: XCTestCase {
    // pokemonCollectionGenerate tests
    func testPokemonIsNotYetRegistered() {
        let pokemonDataModelMock = PokemonDataModel(data: [
            PokemonDataModel.Pokemon(
                id: "ap-1", name: "Ampharos",
                images: PokemonDataModel.ImagesStringUrl(small: "https://images.pokemontcg.io/dp3/1.png")
            ),
        ])
        let currentListLoadedPokemonsMock = [
            PokemonViewModel(id: "ch-1", imageData: Data())
        ]
        let generator = PokemonsListsGenerator()
        
        let result = generator.pokemonCollectionGenerate(pokemonsDataModel: pokemonDataModelMock, currentListLoadedPokemons: currentListLoadedPokemonsMock)
                
        XCTAssertEqual(1, result.count)
        XCTAssertEqual("ap-1", result[0]["id"] as! String)
        XCTAssertEqual(URL(string: "https://images.pokemontcg.io/dp3/1.png"), result[0]["imageUrl"] as? URL)
    }
    
    func testAlreadyLoadedPokemonsListIsEmpty() {
        let pokemonDataModelMock = PokemonDataModel(data: [
            PokemonDataModel.Pokemon(
                id: "ap-1", name: "Ampharos",
                images: PokemonDataModel.ImagesStringUrl(small: "https://images.pokemontcg.io/dp3/1.png")
            ),
        ])
        let currentListLoadedPokemonsMock = [PokemonViewModel]()
        let generator = PokemonsListsGenerator()
        
        let result = generator.pokemonCollectionGenerate(pokemonsDataModel: pokemonDataModelMock, currentListLoadedPokemons: currentListLoadedPokemonsMock)
        
        XCTAssertEqual(1, result.count)
        XCTAssertEqual("ap-1", result[0]["id"] as! String)
        XCTAssertEqual(URL(string: "https://images.pokemontcg.io/dp3/1.png"), result[0]["imageUrl"] as? URL)
    }
    
    func testPokemonIsAlreadyRegistered() {
        let pokemonDataModelMock = PokemonDataModel(data: [
            PokemonDataModel.Pokemon(
                id: "ap-1", name: "Ampharos",
                images: PokemonDataModel.ImagesStringUrl(small: "https://images.pokemontcg.io/dp3/1.png")
            ),
        ])
        let currentListLoadedPokemonsMock = [
            PokemonViewModel(id: "ap-1", imageData: Data())
        ]
        let generator = PokemonsListsGenerator()
        
        let result = generator.pokemonCollectionGenerate(pokemonsDataModel: pokemonDataModelMock, currentListLoadedPokemons: currentListLoadedPokemonsMock)

        XCTAssertTrue(result.isEmpty)
    }
    
    func testShouldRegisterAllPokemonsEventIfTheresOneWithBreakUrl() {
        let pokemonDataModelMock = PokemonDataModel(data: [
            PokemonDataModel.Pokemon(
                id: "at-2", name: "Articuno",
                images: PokemonDataModel.ImagesStringUrl(small: "https://images.pokemontcg.io/base3/2.png")
            ),
            PokemonDataModel.Pokemon(
                id: "ch-1", name: "Charmander",
                images: PokemonDataModel.ImagesStringUrl(small: "")
            ),
        ])
        let currentListLoadedPokemonsMock = [
            PokemonViewModel(id: "ap-1", imageData: Data())
        ]
        let generator = PokemonsListsGenerator()
        
        let result = generator.pokemonCollectionGenerate(pokemonsDataModel: pokemonDataModelMock, currentListLoadedPokemons: currentListLoadedPokemonsMock)
        
        XCTAssertEqual(1, result.count)
    }
    
    // pokemonsViewModelGenerate tests
    func testShouldGenerateViewModelList() {
        let pokemonCollectionMock = [
            [
                "id": "at-2",
                "imageUrl": URL(string: "https://images.pokemontcg.io/base3/2.png")!
            ]
        ]
        let generator = PokemonsListsGenerator()
        
        let result: [PokemonViewModel] = generator.pokemonsViewModelGenerate(pokemonCollection: pokemonCollectionMock)
        
        XCTAssertEqual(1, result.count)
    }
    
    // DUVIDA:AO GERAR A POKEMON COLLECTION, EU JA FAÇO UMA VALIDACAO DE URL, ENTAO NAO TERIA UM CENARIO EM RELACAO A URL INVALIDA AQUI, POIS OS TESTES ACIMA JA COBREM ISSO, CERTO? O METODO ANTERIOR AO pokemonsViewModelGenerate JA FAZ ESSA VALIDACAO
//    func testProvidedPokemonToPokemonViewModelIsNotValid() {
//        let pokemonCollectionMock = [
//            [
//                "id": "at-2",
//                "imageUrl": URL(string: <#T##String#>)
//            ]
//        ]
//        let generator = PokemonsListsGenerator()
//
//        let result: [PokemonViewModel] = generator.pokemonsViewModelGenerate(pokemonCollection: pokemonCollectionMock)
//
//        XCTAssertTrue(result.isEmpty)
//    }
}
