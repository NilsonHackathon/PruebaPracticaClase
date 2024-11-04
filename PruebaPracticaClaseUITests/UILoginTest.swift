//
//  LoginTest.swift
//  PruebaPracticaClaseTests
//
//  Created by User-UAM on 11/3/24.
//

import XCTest

class UILoginTest: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }
    
    func testLoginSuccess() {
        let userTextField = app.textFields["userTextField"]
        let passwordTextField = app.textFields["passwordTextField"]
        let loginButton = app.buttons["loginButton"]
        
        XCTAssertTrue(userTextField.waitForExistence(timeout: 5), "userTextField no está disponible")
        userTextField.tap()
        userTextField.typeText("Nilson")
        
        XCTAssertTrue(passwordTextField.waitForExistence(timeout: 5), "passwordTextField no está disponible")
        passwordTextField.tap()
        passwordTextField.typeText("NilSA24.")
        
        XCTAssertTrue(loginButton.waitForExistence(timeout: 5), "loginButton no está disponible")
        loginButton.tap()
        
        sleep(5)
        
        // Verifica la existencia de mainView en lugar de welcomeView
        let mainView = app.otherElements["mainView"]
        let exists = mainView.waitForExistence(timeout: 10)
        
        XCTAssertTrue(exists, "El segue goToMainView debería haberse ejecutado correctamente y mostrar la vista de bienvenida.")
    }
    
    func testLoginFailure() {
        let userTextField = app.textFields["userTextField"]
        let passwordTextField = app.textFields["passwordTextField"]
        let loginButton = app.buttons["loginButton"]
        
        XCTAssertTrue(userTextField.waitForExistence(timeout: 5), "userTextField no está disponible")
        userTextField.tap()
        userTextField.typeText("UsuarioInvalido")
        
        XCTAssertTrue(passwordTextField.waitForExistence(timeout: 5), "passwordTextField no está disponible")
        passwordTextField.tap()
        passwordTextField.typeText("ContraseñaInvalida")
        
        XCTAssertTrue(loginButton.waitForExistence(timeout: 5), "loginButton no está disponible")
        loginButton.tap()
        
        sleep(2)
        
        let welcomeView = app.otherElements["welcomeView"]
        let exists = welcomeView.waitForExistence(timeout: 5)
        
        XCTAssertFalse(exists, "WelcomeViewController no debería ser presentado con credenciales incorrectas.")
    }
}
