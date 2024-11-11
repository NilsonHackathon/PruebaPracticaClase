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
    
    // Test de inicio de sesión antes de verificar MainViewController
    private func performLoginIfNeeded() {
        // Verificar si estamos en la pantalla de login
        let loginButton = app.buttons["loginButton"]
        
        if loginButton.exists {
            // Rellenar el usuario y contraseña
            let userTextField = app.textFields["userTextField"]
            let passwordTextField = app.textFields["passwordTextField"]
            
            XCTAssertTrue(userTextField.exists, "El campo de usuario debería existir en la pantalla de inicio de sesión.")
            
            XCTAssertTrue(passwordTextField.exists, "El campo de contraseña debería existir en la pantalla de inicio de sesión.")
            
            userTextField.tap()
            userTextField.typeText("Nilson")
            
            passwordTextField.tap()
            passwordTextField.typeText("NilSA24.")
            
            loginButton.tap()
            
            // Verificar que hemos navegado a la pantalla principal
            let mainViewLabel = app.staticTexts["MainViewLabelIdentifier"]
            XCTAssertTrue(mainViewLabel.waitForExistence(timeout: 5), "Debería navegar a la vista principal después del inicio de sesión exitoso.")
        }
    }

    //Test 1: Verificador que todo los elementos necesarios existan
    func testElementsExistence(){
        
        performLoginIfNeeded()
        
        let logoImage = app.images["logoFotoView"]
        XCTAssertTrue(logoImage.exists, "El logoFotoView debería existir en la interfaz.")
        
        //Verifica que el table view exista.
        let tableView = app.tables["tableView"]
        XCTAssertTrue(tableView.exists, "El tableView debería existir en la interfaz.")
    }
    
    //Test 2: Verificar que los elementos sean ineractuables.
    //Verificar que el logo sea interactuable
    func testElementsInteractable(){
        
        performLoginIfNeeded()
        
        let logoImage = app.images["logoFotoView"]
        XCTAssertTrue(logoImage.isHittable, "El logoFotoView debería ser interactuable.")
        
        //verificar que el table view sea interactuable
        let tableView = app.tables["tableView"]
        XCTAssertTrue(tableView.isHittable, "El tableView debería ser interactuable.")
    }
    
    // Test 3: Verificar que la primera y última celda de la lista sean visibles
    func testFirstAndLastCells() {
        performLoginIfNeeded()
        
        let tableView = app.tables["tableView"]
        
        XCTAssertTrue(tableView.cells.count > 0, "El tableView debería tener celdas para realizar esta prueba.")
        
        let firstCell = tableView.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.exists, "La primera celda debería existir.")
        XCTAssertTrue(firstCell.isHittable, "La primera celda debería ser visible y interactuable.")
        
        // Scroll hasta la última celda
        let lastCellIndex = tableView.cells.count - 1
        let lastCell = tableView.cells.element(boundBy: lastCellIndex)
        
        while !lastCell.isHittable {
            tableView.swipeUp()
        }
        
        XCTAssertTrue(lastCell.exists, "La última celda debería existir.")
        XCTAssertTrue(lastCell.isHittable, "La última celda debería ser visible y interactuable.")
    }
}
