//
//  ViewControllerUITests.swift
//  PokemonApiConsumerUITests
//
//  Created by Leonardo Leite on 14/03/24.
//

import XCTest

final class ViewControllerUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    func testTapTableRowOpenAnotherViewAndShouldCloseIt() throws {
        let app = XCUIApplication()
        app.launch()
                    
        app.tables.staticTexts["Celebi & Venusaur-GX - sm9-1"].tap()
        app.buttons["X Circle"].tap()
        
        app.tables.staticTexts["Ampharos - dp3-1"].tap()
        app.buttons["X Circle"].tap()
    }
    
    func testTableViewScroll() {
        let app = XCUIApplication()
        app.launch()
        
        let tableView = app.tables["tableView"]
        let exists = NSPredicate(format: "exists == 1")
        let firstCell = tableView.cells.firstMatch
        
        let expectation = expectation(for: exists, evaluatedWith: firstCell)
        waitForExpectations(timeout: 5) { _ in
            XCTAssertTrue(firstCell.exists, "first table cell was loaded")
            expectation.fulfill()
        }
        
            
        let totalCells = tableView.cells.count
        let lastTableCell = tableView.cells.allElementsBoundByIndex[totalCells - 1]
        
        while !lastTableCell.isHittable {
            tableView.swipeUp()
        }
        
        XCTAssertTrue(lastTableCell.isHittable)
    }
    
    func testLoadMoreCellsWhenReachesAtTheEndOfList() {
        let app = XCUIApplication()
        app.launch()
        
        let tableView = app.tables["tableView"]
        let exists = NSPredicate(format: "exists == 1")
        let firstCell = tableView.cells.firstMatch
        
        let expectation = expectation(for: exists, evaluatedWith: firstCell)
        waitForExpectations(timeout: 5) { _ in
            expectation.fulfill()
        }
            
        let initialTotalCells = tableView.cells.count
        let lastTableCell = tableView.cells.allElementsBoundByIndex[initialTotalCells - 1]
        print(initialTotalCells)
        
        while !lastTableCell.isHittable {
            tableView.swipeUp()
        }
        
        let isTableCellsQuantityGreaterThanInitial = initialTotalCells < tableView.cells.count
        XCTAssertTrue(isTableCellsQuantityGreaterThanInitial)
    }
}
