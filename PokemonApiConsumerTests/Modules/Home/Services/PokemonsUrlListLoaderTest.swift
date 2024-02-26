//
//  PokemonsUrlListLoaderTest.swift
//  PokemonApiConsumerTests
//
//  Created by Izadora Matias on 20/02/24.
//

import XCTest
@testable import PokemonApiConsumer

class PokemonsUrlListLoaderTest: XCTestCase {
    func testPokemonDataModelListThereAreNoPokemons() {
        class PokemonsRepositoryMock: PokemonsRepository {
            override func getPokemons(completion: @escaping (PokemonDataModel?) -> Void, totalPokemonsPerPage: Int, page: Int) {
                let pokemonsDataModelMock = PokemonDataModel(data: [])
                completion(pokemonsDataModelMock)
            }
        }
        
        let pokemonsDataModelListLoader = PokemonsDataModelListLoader(pokemonsRepository: PokemonsRepositoryMock())
        let expectation = expectation(description: "get the repository async result")
        var result: PokemonDataModel? = nil
        
        pokemonsDataModelListLoader.loadPokemonsDataModelList(completion: { pokemonsDataModel in
            result = pokemonsDataModel
            
            expectation.fulfill()
        }, totalPokemonsPerPage: 0, currentPage: 0)
        
        waitForExpectations(timeout: 1) { _ in
            XCTAssertTrue(result!.data.isEmpty)
        }
    }
    
    func testPokemonsDataModelThereArePokemons() {
        class PokemonsRepositoryMock: PokemonsRepository {
            override func getPokemons(completion: @escaping (PokemonDataModel?) -> Void, totalPokemonsPerPage: Int, page: Int) {
                let pokemonsDataModelMock = PokemonDataModel(data: [
                    PokemonDataModel.Pokemon(id: "ap-1", name: "Ampharos", images: PokemonDataModel.ImagesStringUrl(small: "https://images.pokemontcg.io/dp3/1.png")),
                    PokemonDataModel.Pokemon(id: "ap-1", name: "Ampharos", images: PokemonDataModel.ImagesStringUrl(small: "https://images.pokemontcg.io/dp3/1.png")),
                ])
                completion(pokemonsDataModelMock)
            }
        }
        
        let pokemonsDataModelListLoader = PokemonsDataModelListLoader(pokemonsRepository: PokemonsRepositoryMock())
        let expectation = expectation(description: "get the repository async result")
        var result: PokemonDataModel? = nil

        pokemonsDataModelListLoader.loadPokemonsDataModelList(completion: { pokemonsDataModel in
            result = pokemonsDataModel

            expectation.fulfill()
        }, totalPokemonsPerPage: 0, currentPage: 0)

        waitForExpectations(timeout: 1) { _ in
            XCTAssertEqual(2, result!.data.count)
        }
    }
}
