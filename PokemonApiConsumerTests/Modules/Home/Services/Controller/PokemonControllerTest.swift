//
//  PokemonControllerTest.swift
//  PokemonApiConsumerTests
//
//  Created by Izadora Matias on 27/02/24.
//

import XCTest
@testable import PokemonApiConsumer

final class PokemonControllerTest: XCTestCase {
    var pokemonsDataLoaderMock: PokemonsDataLoaderMock!
    var sut: PokemonController!
    let pokemonControllerDelegateMock = PokemonControllerDelegateMock()
    let detailControllerDelegateMock = DetailControllerDelegateMock()
    
    override func setUp() {
        self.pokemonsDataLoaderMock = PokemonsDataLoaderMock()
        self.sut = PokemonController(
            delegate: pokemonControllerDelegateMock,
            detailDelegate: detailControllerDelegateMock,
            pokemonsDataModelListLoader: self.pokemonsDataLoaderMock,
            pokemonsFinder: PokemonsFinderMock()
        )
    }
    
    // MARK: Tests of loadPokemons
    func testShouldCallDidEnterInLoadingOnceWhenLoadingPokemons() {
        sut.loadPokemons(currentPokemonsList: [PokemonViewData]())
        XCTAssertEqual(1, pokemonControllerDelegateMock.countOf_didEnterInLoading)
    }
    
    func testShouldCallDidGetPokemonsViewDataListOnceWhenLoadingPokemons() {
        self.pokemonsDataLoaderMock.resultOf_LoadPokemonsDataModelList = PokemonDataModel(data: [])
        
        sut.loadPokemons(currentPokemonsList: [PokemonViewData]())
        XCTAssertEqual(1, pokemonControllerDelegateMock.countOf_didGetPokemonsViewDataList)
    }
    
    func testShouldCallDidStopInErrorOnceWhenLoadingPokemonsIsInvalid() {
        pokemonsDataLoaderMock.resultOf_LoadPokemonsDataModelList = nil
        
        sut.loadPokemons(currentPokemonsList: [PokemonViewData]())
        
        XCTAssertEqual(1, pokemonControllerDelegateMock.countOf_didStopInError)
    }
    
    // MARK: Tests of loadCardImage
    func testShouldCallDidEnterInLoadingCardOnceWhenLoadingCard() {
        sut.loadCardImage(pokemonId: "")
        XCTAssertEqual(1, detailControllerDelegateMock.countOf_didEnterInLoadingCard)
    }
    
    func testShouldCallDidGetCardImageOnceWhenLoadingCard() {
        self.pokemonsDataLoaderMock.resultOf_LoadPokemonCardModel = PokemonCardModel(data: PokemonCardModel.Card(images: PokemonCardModel.Images(large: "https://images.pokemontcg.io/hgss4/1_hires.png")))

        sut.loadCardImage(pokemonId: "")
        XCTAssertEqual(1, detailControllerDelegateMock.countOf_didGetCardImage)
    }
    
    func testShouldCallDidStopInErrorOnceWhenLoadingCardIsInvalid() {
        pokemonsDataLoaderMock.resultOf_LoadPokemonCardModel = nil
        
        sut.loadCardImage(pokemonId: "")
        
        XCTAssertEqual(1, detailControllerDelegateMock.countOf_didStopInError)
    }
}
