//
//  PokemonsImageDataListGeneratorTest.swift
//  PokemonApiConsumerTests
//
//  Created by Leonardo Leite on 19/02/24.
//

import XCTest
@testable import PokemonApiConsumer

final class PokemonsImageDataListGeneratorTest: XCTestCase {

    func testShouldReturnAnArrayOfData() {
        let urlsListMock: [URL] = [
            URL(string: "https://images.pokemontcg.io/ex11/1.png")!,
            URL(string: "https://images.pokemontcg.io/ex11/1.png")!,
            URL(string: "https://images.pokemontcg.io/ex11/1.png")!,
        ]
        
        let generator = PokemonsListsGenerator()
        
        let result = generator.dataListGenerate(urls: urlsListMock)
                
        XCTAssertEqual(3, result.count)
    }
}
