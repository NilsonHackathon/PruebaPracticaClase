//
//  UIRegisterViewControllerTest.swift
//  PruebaPracticaClaseUITests
//
//  Created by User-UAM on 11/8/24.
//
import XCTest

class UIRegisterViewControllerTest: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {
        // Tear down code
    }

    func testEmptyFieldsError() {
        navigateToRegister()
        
        // Verificar que los campos están presentes
        let nameTextField = app.textFields["register_nameTextField"]
        let userIDTextField = app.textFields["register_userIDTextField"]
        let phoneTextField = app.textFields["register_phoneTextField"]
        let passwordTextField = app.textFields["register_passwordTextField"]
        let secondPassTextField = app.textFields["register_secondPassTextField"]
        let registerActionButton = app.buttons["register_registerButton"]

        // Verificar los elementos y hacer scroll si es necesario
        scrollAndVerifyElements([nameTextField, userIDTextField, phoneTextField, passwordTextField, secondPassTextField], app: app)
        
        // Tap en el botón de registro sin llenar los campos
        registerActionButton.tap()
        
        // Verificar que aparece la alerta de campos vacíos
        let errorAlert = app.alerts["errorAlert"]
        XCTAssertTrue(errorAlert.waitForExistence(timeout: 5), "Debería aparecer una alerta de error de campos vacíos.")
    }

    func testPasswordMismatchError() {
        navigateToRegister()
        
        let nameTextField = app.textFields["register_nameTextField"]
        let userIDTextField = app.textFields["register_userIDTextField"]
        let phoneTextField = app.textFields["register_phoneTextField"]
        let passwordTextField = app.textFields["register_passwordTextField"]
        let secondPassTextField = app.textFields["register_secondPassTextField"]
        let registerActionButton = app.buttons["register_registerButton"]

        // Ingresar datos válidos excepto por la contraseña y hacer scroll si es necesario
        enterTextAndScroll("Juan Pérez", in: nameTextField, app: app)
        enterTextAndScroll("jperez", in: userIDTextField, app: app)
        enterTextAndScroll("1234567890", in: phoneTextField, app: app)
        enterTextAndScroll("ContraseñaIncorrecta", in: passwordTextField, app: app)
        enterTextAndScroll("OtraContraseña", in: secondPassTextField, app: app)
        dismissKeyboardIfNeeded(app: app)
        
        // Tap en el botón de registro
        registerActionButton.tap()
        
        // Verificar que aparece la alerta de contraseñas no coinciden
        let errorAlert = app.alerts["errorAlert"]
        XCTAssertTrue(errorAlert.waitForExistence(timeout: 5), "Debería aparecer una alerta de error de contraseñas no coinciden.")
    }

    func testSuccessfulRegistration() {
        navigateToRegister()
        
        let nameTextField = app.textFields["register_nameTextField"]
        let userIDTextField = app.textFields["register_userIDTextField"]
        let phoneTextField = app.textFields["register_phoneTextField"]
        let passwordTextField = app.textFields["register_passwordTextField"]
        let secondPassTextField = app.textFields["register_secondPassTextField"]
        let registerActionButton = app.buttons["register_registerButton"]

        // Ingresar datos válidos en todos los campos
        enterTextAndScroll("Juan Pérez", in: nameTextField, app: app)
        enterTextAndScroll("jperez", in: userIDTextField, app: app)
        enterTextAndScroll("1234567890", in: phoneTextField, app: app)
        enterTextAndScroll("Contraseña123", in: passwordTextField, app: app)
        enterTextAndScroll("Contraseña123", in: secondPassTextField, app: app)
        dismissKeyboardIfNeeded(app: app)
        
        // Tap en el botón de registro
        registerActionButton.tap()
        
        // Verificar que se navega a la vista principal
        /*let mainViewLabel = app.staticTexts["MainViewLabelIdentifier"]
        XCTAssertTrue(mainViewLabel.waitForExistence(timeout: 5), "Debería volver a la vista principal después de un registro exitoso.")*/
        
        // Verificar que aparece la alerta de éxito
            let successAlert = app.alerts["successAlert"]
            XCTAssertTrue(successAlert.waitForExistence(timeout: 5), "Debería aparecer una alerta de éxito después de un registro exitoso.")
    }

    // Navegar a la pantalla de registro desde la pantalla de login
    private func navigateToRegister() {
        let registerButtonOnLogin = app.buttons["registerButtonOnLogin"]
        XCTAssertTrue(registerButtonOnLogin.exists, "El botón de registro en Login debería existir.")
        registerButtonOnLogin.tap()
    }
    
    // Verificar la existencia de los elementos y hacer scroll si es necesario
    private func scrollAndVerifyElements(_ elements: [XCUIElement], app: XCUIApplication) {
        for element in elements {
            gradualScrollToElement(element: element, app: app)
            XCTAssertTrue(element.exists, "El elemento debería estar presente y alcanzable.")
        }
    }
    
    // Ingresar texto y hacer scroll si es necesario
    private func enterTextAndScroll(_ text: String, in textField: XCUIElement, app: XCUIApplication) {
        gradualScrollToElement(element: textField, app: app)
        XCTAssertTrue(textField.exists, "El campo de texto debería estar presente y alcanzable.")
        textField.tap()
        textField.typeText(text)
    }
}

// Función de desplazamiento gradual hasta que el elemento sea visible
func gradualScrollToElement(element: XCUIElement, app: XCUIApplication, maxAttempts: Int = 10) {
    var attempts = 0
    while !element.isHittable && attempts < maxAttempts {
        let start = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.6)) // Empieza desde una posición más alta
        let end = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.2))   // Baja a una posición intermedia
        start.press(forDuration: 0.05, thenDragTo: end) // Pequeño desplazamiento hacia abajo

        sleep(1) // Pausa para permitir que el desplazamiento se complete
        attempts += 1
    }
}

// Función para ocultar el teclado tocando fuera de los campos de texto
func dismissKeyboardIfNeeded(app: XCUIApplication) {
    if app.keyboards.count > 0 {
        let tapPoint = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.1))
        tapPoint.tap()
    }
}
