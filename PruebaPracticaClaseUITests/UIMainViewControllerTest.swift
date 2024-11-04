//
//  UIMainViewControllerTest.swift
//  PruebaPracticaClaseUITests
//
//  Created by User-UAM on 11/4/24.
//

import XCTest

class UIMainViewControllerTest: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    //Test 1: Verificador que todo los elementos necesarios existan
    func testElementsExistence(){
        let logoImage = app.images["logoFotoView"]
        XCTAssertTrue(logoImage.exists, "El logoFotoView debería existir en la interfaz.")
        
        //Verifica que el table view exista.
        let tableView = app.tables["tableView"]
        XCTAssertTrue(tableView.exists, "El tableView debería existir en la interfaz.")
    }
    
    //Test 2: Verificar que los elementos sean ineractuables.
    //Verificar que el logo sea interactuable
    func testElementsInteractable(){
        
        let logoImage = app.images["logoFotoView"]
        XCTAssertTrue(logoImage.isHittable, "El logoFotoView debería ser interactuable.")
        
        //verificar que el table view sea interactuable
        let tableView = app.tables["tableView"]
        XCTAssertTrue(tableView.isHittable, "El tableView debería ser interactuable.")
    }
    
    //Test 3: Verificar que la primera y última celda de la lsita sean visible
    func testFirsAndLastCells(){
        let tableView = app.tables["tableView"]
        
        //Esperar que el table view tenga celdas
        XCTAssertTrue(tableView.cells.count > 0, "El tableView debería tener celda para realizar esta prueba")
        
        //Verificar que la primera celda sea visible
        let firstCell = tableView.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.exists, "La primera celda debería existir.")
        XCTAssertTrue(firstCell.isHittable, "La primera celda debería ser visible y interactuable.")
        
        //Verificar que la última celda sea visible
        let lastCell = tableView.cells.element(boundBy: tableView.cells.count - 1)
        XCTAssertTrue(lastCell.exists, "La última celda debería existir.")
        XCTAssertTrue(lastCell.isHittable, "La última celda debería ser visible y interactuable.")
    }
}
