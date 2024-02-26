//
//  PokemonDataConverterTest.swift
//  PokemonApiConsumerTests
//
//  Created by Izadora Matias on 05/03/24.
//

import XCTest
@testable import PokemonApiConsumer

final class PokemonDataConverterTest: XCTestCase {
    var sut: PokemonDataConverter!
    
    override func setUp() {
        self.sut = PokemonDataConverter()
    }
    
    // MARK: Tests of convertToUrl
    func testShouldConvertCardDataToUrlWhenPokemonCardModelIsValid() {
        let pokemonCardModel: PokemonCardModel? = PokemonCardModel(data: PokemonCardModel.Card(images: PokemonCardModel.Images(large: "https://images.pokemontcg.io/hgss4/1_hires.png")))
                
        let result: URL? = sut.convertToUrl(cardModel: pokemonCardModel)!
        
        XCTAssertEqual(URL(string: "https://images.pokemontcg.io/hgss4/1_hires.png"), result)
    }
    
    func testShouldBeNilWhenPokemonCardModelIsInvalid() {
        let pokemonCardModel: PokemonCardModel? = nil
                
        let result: URL? = sut.convertToUrl(cardModel: pokemonCardModel)
        
        XCTAssertNil(result)
    }
    
    func testShouldBeNilWhenModelUrlIsInvalid() {
        let pokemonCardModel: PokemonCardModel? = PokemonCardModel(data: PokemonCardModel.Card(images: PokemonCardModel.Images(large: "")))
        
        let result: URL? = sut.convertToUrl(cardModel: pokemonCardModel)
        
        XCTAssertNil(result)
    }
    
    // MARK: Tests of convertToData
    func testShouldConvertToDataWhenUrlIsValid() {
        let url: URL? = URL(string: "https://images.pokemontcg.io/hgss4/1_hires.png")
                
        let result: Data? = sut.convertToData(cardUrl: url)!
        
        XCTAssertEqual(try Data(contentsOf: URL(string: "https://images.pokemontcg.io/hgss4/1_hires.png")!), result)
    }
    
    func testShouldBeNilWhenUrlIsInvalid() {
        let url: URL? = URL(string: "")
                
        let result: Data? = sut.convertToData(cardUrl: url)
        
        XCTAssertNil(result)
    }
}
