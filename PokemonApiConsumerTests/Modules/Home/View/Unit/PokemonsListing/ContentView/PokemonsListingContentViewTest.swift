//
//  PokemonsListingContentViewTest.swift
//  PokemonApiConsumerTests
//
//  Created by Leonardo Leite on 12/03/24.
//

import XCTest
import UIKit
@testable import PokemonApiConsumer

final class PokemonsListingContentViewTest: XCTestCase {
    let sut = PokemonsListingContentView()
    
    func testTableViewShouldHasTwoSubviews() {
        XCTAssertEqual(2, sut.subviews.count)
    }
}
