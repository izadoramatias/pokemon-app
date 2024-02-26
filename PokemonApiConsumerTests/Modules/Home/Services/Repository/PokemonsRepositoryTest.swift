//
//  PokemonsRepositoryTest.swift
//  PokemonApiConsumerTests
//
//  Created by Izadora Matias on 28/02/24.
//

import XCTest
@testable import PokemonApiConsumer

final class PokemonsRepositoryTest: XCTestCase {
    var urlSession: UrlSessionDataProviderMock!
    var sut: PokemonsRepository!
    
    override func setUp() {
        urlSession = UrlSessionDataProviderMock()
        sut = .init(urlSession: urlSession)
    }
    
    // MARK: Tests of getPokemons
    func testShouldNotifyErrorWhenGetPokemonsFailWithRequestError() {
        urlSession.error = NSError()
        
        sut.getPokemons(totalPokemonsPerPage: 0, page: 0) { result in
            XCTAssertEqual(result, .failure(.error))
        }
    }
    
    func testShouldNotifyErrorWhenGetPokemonsFailWithGenericError() {
        urlSession.response = HTTPURLResponse(url: URL(string: "a.com")!, statusCode: 404, httpVersion: "1.1", headerFields: ["":""])
        
        sut.getPokemons(totalPokemonsPerPage: 0, page: 0) { result in
            XCTAssertEqual(result, .failure(.requestError))
        }
    }
    
    func testGetPokemonsShouldNotifyErrorWhenWasNotPossibleDecodeData() {
        urlSession.data = Data()
        
        sut.getPokemons(totalPokemonsPerPage: 0, page: 0) { result in
            XCTAssertEqual(result, .failure(.decodeError))
        }
    }
    
    func testShouldDecodeForPokemonDataModelWithSuccess() {
        let stringJson: String = """
        {
            "data": [
                {
                    "id": "hgss4-1",
                    "name": "Aggron",
                    "supertype": "Pokémon",
                    "subtypes": [
                        "Stage 2"
                    ],
                }
            ]
        }
        """
        urlSession.data = Data(stringJson.utf8)

        sut.getPokemons(totalPokemonsPerPage: 0, page: 0) { result in
            XCTAssertEqual(result, .success(PokemonDataModel(data: [PokemonDataModel.Pokemon(id: "hgss4-1", name: "Aggron")])))
        }
    }
    
    // MARK: Tests of getCard
    func testShouldNotifyWhenGetCardFailWithRequestError() {
        urlSession.response = HTTPURLResponse(url: URL(string: "a.com")!, statusCode: 404, httpVersion: "1.1", headerFields: ["":""])
        
        sut.getCard(cardId: "") { result in
            XCTAssertEqual(result, .failure(.requestError))
        }
    }
    
    func testShouldNotifyWhenGetCardFailtWithGenericError() {
        urlSession.error = NSError()
        
        sut.getCard(cardId: "") { result in
            XCTAssertEqual(result, .failure(.error))
        }
    }
    
    func testGetCardShouldNotifyErrorWhenWasNotPossibleDecodeData() {
        urlSession.data = Data()
        
        sut.getCard(cardId: "") { result in
            XCTAssertEqual(result, .failure(.decodeError))
        }
    }
    
    func testGetCardShouldDecodeForPokemonCardModelWithSuccess() {
        let stringJson: String = """
        {
            "data": {
                "images": {
                    "small": "https://images.pokemontcg.io/hgss4/1.png",
                    "large": "https://images.pokemontcg.io/hgss4/1_hires.png"
                }
            }
        }
        """
        urlSession.data = Data(stringJson.utf8)
        
        sut.getCard(cardId: "") { result in
            XCTAssertEqual(result, .success(PokemonCardModel(data: PokemonCardModel.Card(images: PokemonCardModel.Images(large: "https://images.pokemontcg.io/hgss4/1_hires.png")))))
        }
    }
}
