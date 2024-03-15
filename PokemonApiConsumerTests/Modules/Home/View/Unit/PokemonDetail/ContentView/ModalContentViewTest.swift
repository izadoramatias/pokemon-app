//
//  ModalContentViewTest.swift
//  PokemonApiConsumerTests
//
//  Created by Leonardo Leite on 13/03/24.
//

import XCTest
import UIKit
@testable import PokemonApiConsumer

final class ModalContentViewTest: XCTestCase {
    let sut = ModalContentView()
    
    func testContentViewShouldHasFiveSubviews(){
        XCTAssertEqual(5, sut.subviews.count)
    }
    
    func testContentViewShouldHasCustomBackgroundColor(){
        let customBackgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)
        XCTAssertEqual(customBackgroundColor, sut.backgroundColor)
    }
}
