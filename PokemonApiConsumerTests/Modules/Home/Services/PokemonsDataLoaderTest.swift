//
//  PokemonsUrlListLoaderTest.swift
//  PokemonApiConsumerTests
//
//  Created by Izadora Matias on 20/02/24.
//

import XCTest
@testable import PokemonApiConsumer

class PokemonsDataLoaderTest: XCTestCase {
    var repository = PokemonsRepositoryMock()
    
    override func setUp() {
        repository = PokemonsRepositoryMock()
    }
    
    // MARK: Tests of loadPokemonsDataModelList()
    func testPokemonDataModelListThereAreNoPokemons() {
        let repositoryResponse = Result<PokemonDataModel?, Errors>.success(PokemonDataModel(data: []))
        repository.returnOf_getPokemons = repositoryResponse

        let sut = PokemonsDataLoader(pokemonsRepository: repository)
        let expectation = expectation(description: "get the repository data model list result without data")
        var result: PokemonDataModel? = nil

        sut.loadPokemonsDataModelList(totalPokemonsPerPage: 0, currentPage: 0) { pokemonsDataModel in
            result = pokemonsDataModel
            
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1) { _ in
            XCTAssertTrue(result!.data.isEmpty)
        }
    }

    func testPokemonsDataModelThereArePokemons() {
        let repositoryResponse = Result<PokemonDataModel?, Errors>.success(PokemonDataModel(data: [PokemonDataModel.Pokemon(id: "ap-1", name: "Ampharos"), PokemonDataModel.Pokemon(id: "ap-1", name: "Ampharos")]))
        repository.returnOf_getPokemons = repositoryResponse
        
        let sut = PokemonsDataLoader(pokemonsRepository: repository)
        let expectation = expectation(description: "get the repository data model list result with data")
        var result: PokemonDataModel? = nil

        sut.loadPokemonsDataModelList(totalPokemonsPerPage: 0, currentPage: 0) { pokemonsDataModel in
            result = pokemonsDataModel

            expectation.fulfill()
        }

        waitForExpectations(timeout: 1) { _ in
            XCTAssertEqual(2, result!.data.count)
        }
    }
    
    func testPokemonsDataModelLoaderCouldNotLoadingItsPokemonsDataModelList() {
        let repositoryResponse = Result<PokemonDataModel?, Errors>.success(nil)
        repository.returnOf_getPokemons = repositoryResponse

        let sut = PokemonsDataLoader(pokemonsRepository: repository)
        let expectation = expectation(description: "get the repository nil result")
        var result: PokemonDataModel? = PokemonDataModel(data: [])

        sut.loadPokemonsDataModelList(totalPokemonsPerPage: 0, currentPage: 0) { pokemonsDataModel in
            result = pokemonsDataModel

            expectation.fulfill()
        }

        waitForExpectations(timeout: 1) { _ in
            XCTAssertEqual(nil, result)
        }
    }
    
    func testPokemonsDataModelListLoaderFailsWhenLoadingPokemons() {
        let repositoryResponse = Result<PokemonDataModel?, Errors>.failure(.requestError)
        repository.returnOf_getPokemons = repositoryResponse
        
        let sut = PokemonsDataLoader(pokemonsRepository: repository)
        let expectation = expectation(description: "get the repository async result")
        var result: PokemonDataModel? = PokemonDataModel(data: [])

        sut.loadPokemonsDataModelList(totalPokemonsPerPage: 0, currentPage: 0) { pokemonsDataModel in
            result = pokemonsDataModel
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { _ in
            XCTAssertEqual(nil, result)
        }
    }
    
    // MARK: Tests of loadPokemonCardModel()
    func testShouldLoadPokemonCardWithSuccess() {
        let repositoryResponse = Result<PokemonCardModel?, Errors>.success(PokemonCardModel(data: PokemonCardModel.Card(images: PokemonCardModel.Images(large: "https://images.pokemontcg.io/base3/2_hires.png"))))
        repository.returnOf_getCard = repositoryResponse
        
        let sut = PokemonsDataLoader(pokemonsRepository: repository)
        let expectation = expectation(description: "get the repository async result")
        var result: PokemonCardModel? = nil
        
        sut.loadPokemonCardModel(cardId: "") { pokemonCardModel in
            result = pokemonCardModel
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { _ in
            XCTAssertEqual("https://images.pokemontcg.io/base3/2_hires.png", result?.data.images.large)
        }
    }
    
    func testWhenWasNotPossibleToLoadCardShouldSuccess() {
        let repositoryResponse = Result<PokemonCardModel?, Errors>.success(nil)
        repository.returnOf_getCard = repositoryResponse
        
        let sut = PokemonsDataLoader(pokemonsRepository: repository)
        let expectation = expectation(description: "get the repository async result")
        var result: PokemonCardModel? = PokemonCardModel(data: PokemonCardModel.Card(images: PokemonCardModel.Images(large: "")))
        
        sut.loadPokemonCardModel(cardId: "") { pokemonCardModel in
            result = pokemonCardModel
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { _ in
            XCTAssertEqual(nil, result)
        }
    }
    
    
    func testPokemonCardLoadingShouldFail() {
        let repositoryResponse = Result<PokemonCardModel?, Errors>.failure(.requestError)
        repository.returnOf_getCard = repositoryResponse
        
        let sut = PokemonsDataLoader(pokemonsRepository: repository)
        let expectation = expectation(description: "get the repository async result")
        var result: PokemonCardModel? = PokemonCardModel(data: PokemonCardModel.Card(images: PokemonCardModel.Images(large: "")))

        sut.loadPokemonCardModel(cardId: "") { pokemonCardModel in
            result = pokemonCardModel
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 0) { _ in
            XCTAssertEqual(nil, result)
        }
    }
}
