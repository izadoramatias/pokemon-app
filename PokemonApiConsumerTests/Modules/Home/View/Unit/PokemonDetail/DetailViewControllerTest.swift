//
//  DetailViewControllerTest.swift
//  PokemonApiConsumerTests
//
//  Created by Leonardo Leite on 14/03/24.
//

import XCTest
import UIKit
@testable import PokemonApiConsumer

final class DetailViewControllerTest: XCTestCase {
    var sut: DetailViewController!
    var controllerMock: PokemonControllerMock!
    
    override func setUp() {
        sut = DetailViewController()
        controllerMock = PokemonControllerMock()
    }
    
    func testDetailModalTitleIsInvalidWhenThereIsNoValidOnePassedToIt() {
        sut.viewWillAppear(true)
        XCTAssertEqual(nil, sut.modalContentView.detailTitle.text)
    }
    
    func testViewControllerShouldUseSystemBackgroundColor() {
        XCTAssertEqual(UIColor.systemBackground, sut.view.backgroundColor)
    }
    
    //    func testErrorComponentShouldAppearWhenThereIsNoValidCardToShow() {
    //        sut.viewWillAppear(true)
    //        XCTAssertFalse(sut.modalContentView.errorComponent.isHidden)
    //    }
    
//    func testShouldShowPokemonCardWhenValidCardIsProvided() {
//        controllerMock.cardData = try! Data(contentsOf: URL(string:"https://images.pokemontcg.io/hgss4/1_hires.png")!)
//        controllerMock.detailDelegate = sut
//        sut.pokemonController = controllerMock
//        sut.viewWillAppear(true)
//        
//        sut.pokemonController.loadCardImage(pokemonId: "")
//                
//        XCTAssertTrue(sut.modalContentView.errorComponent.isHidden)
//        XCTAssertEqual(UIImage(data: try! Data(contentsOf: URL(string:"https://images.pokemontcg.io/hgss4/1_hires.png")!)), sut.modalContentView.card.cardImage.image)
//    }

}
