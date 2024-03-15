//
//  ViewControllerTest.swift
//  PokemonApiConsumerTests
//
//  Created by Leonardo Leite on 13/03/24.
//C

import XCTest
import UIKit
@testable import PokemonApiConsumer

final class ViewControllerTest: XCTestCase {
    var sut: ViewController!
    var pokemonViewDataListMock: [PokemonViewData]!
    var tableView: UITableView!
    
    override func setUp() {
        sut = ViewController()
        tableView = UITableView()
    }
    
    func testTableViewShouldHasThreeRows() {
        pokemonViewDataListMock = [
            PokemonViewData(id: "pk1", name: "pokemon 1"),
            PokemonViewData(id: "pk2", name: "pokemon 2"),
            PokemonViewData(id: "pk3", name: "pokemon 3"),
        ]
        sut.pokemonsViewDataList = pokemonViewDataListMock
        
        let result: Int = sut.tableView(tableView, numberOfRowsInSection: 0)
        
        XCTAssertEqual(3, result)
    }
    
    func testShouldBuildViewControllerWithOneRow() {
        pokemonViewDataListMock = [PokemonViewData(id: "pk1", name: "pokemon 1")]
        tableView.register(CustomCellContent.self, forCellReuseIdentifier: "customCellContent")
        sut.pokemonsViewDataList = pokemonViewDataListMock

        let result: CustomCellContent = sut.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! CustomCellContent
        
        let expected = tableView.dequeueReusableCell(withIdentifier: "customCellContent", for: IndexPath(row: 0, section: 0)) as! CustomCellContent
        expected.label.text = "pokemon 1 - pk1"
        expected.backgroundColor = UIColor(red: 254/255, green: 251/255, blue: 240/255, alpha: 0.4)

        XCTAssertEqual(expected.label.text, result.label.text)
        XCTAssertEqual(expected.backgroundColor, result.backgroundColor)
    }
    
    func testShouldLoadMoreTableItems() {
        let newPokemonListToLoad: [PokemonViewData] = [
            PokemonViewData(id: "pk7", name: "pokemon 7"),
            PokemonViewData(id: "pk8", name: "pokemon 8")
        ]
        let pokemonControllerMock = PokemonControllerMock()
        pokemonControllerMock.delegate = sut
        
        pokemonViewDataListMock = [
            PokemonViewData(id: "pk1", name: "pokemon 1"),
            PokemonViewData(id: "pk2", name: "pokemon 2"),
            PokemonViewData(id: "pk3", name: "pokemon 3"),
            PokemonViewData(id: "pk4", name: "pokemon 4"),
            PokemonViewData(id: "pk5", name: "pokemon 5"),
            PokemonViewData(id: "pk6", name: "pokemon 6"),
        ]
        sut.pokemonsViewDataList = pokemonViewDataListMock
        sut.pokemonController = pokemonControllerMock
        tableView.register(CustomCellContent.self, forCellReuseIdentifier: "customCellContent")
        
        _ = sut.tableView(tableView, cellForRowAt: IndexPath(row: pokemonViewDataListMock.count - 5, section: 0))
        
        sut.pokemonController.loadPokemons(currentPokemonsList: newPokemonListToLoad)
        
        XCTAssertEqual(8, sut.pokemonsViewDataList.count)
    }
    
//    func testShouldLoadCardImageByPokemonId() {
//    }
    
    func testViewControllerShouldHasSystemBackgroundColor() {
        XCTAssertEqual(UIColor.systemBackground, sut.view.backgroundColor)
    }
}
