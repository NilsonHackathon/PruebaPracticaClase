//
//  ViewController.swift
//  PruebaPracticaClase
//
//  Created by User-UAM on 10/31/24.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        
        userTextField.accessibilityIdentifier = "userTextField"
        passwordTextField.accessibilityIdentifier = "passwordTextField"
        loginButton.accessibilityIdentifier = "loginButton"
        registerButton.accessibilityIdentifier = "registerButtonOnLogin"
        
    }
    
    func authenticateUser(username: String, password: String) -> Bool {
        return username == "Nilson" && password == "NilSA24."
    }
    
    func performLogin(username: String? = nil, password: String? = nil) {
        let enteredUsername = username ?? userTextField.text ?? ""
            let enteredPassword = password ?? passwordTextField.text ?? ""
            
            guard authenticateUser(username: enteredUsername, password: enteredPassword)
            else {
                print("Credenciales incorrectas")
                showLoginErrorAlert()  // Muestra la alerta en caso de error
                return
            }
            
            // Ejecutamos el segue de la vista del main
            print("Segue ejecutándose")
            performSegue(withIdentifier: "goToMainView", sender: self)
    }
    
    private func showLoginErrorAlert() {
        let alert = UIAlertController(title: "Error", message: "Credenciales incorrectas", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert.view.accessibilityIdentifier = "loginErrorAlert"
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        performLogin()
    }
    
    @IBAction func RegisterButtonAction(_ sender: Any) {
        //Navegamos a RegisterVC usando el identificador.
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let registerVC = storyBoard.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController
        else {
            print("No se encontró el RegisterViewController")
            return
        }
        
        self.present(registerVC, animated: true, completion: nil)
    }
}

