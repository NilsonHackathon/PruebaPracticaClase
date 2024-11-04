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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        
        userTextField.accessibilityIdentifier = "userTextField"
        passwordTextField.accessibilityIdentifier = "passwordTextField"
        loginButton.accessibilityIdentifier = "loginButton"
    }
    
    func authenticateUser(username: String, password: String) -> Bool {
        return username == "Nilson" && password == "NilSA24."
    }
    
    func performLogin(username: String? = nil, password: String? = nil) {
        let enteredUsername = username ?? userTextField.text ?? ""
        let enteredPassword = password ?? passwordTextField.text ?? ""
        
        guard authenticateUser(username: enteredUsername, password: enteredPassword)
        else{
            print("Credenciales incorrectas")
            return
        }
        
        //Ejecutamos el segue de la vista del main
        print("Segue ejecutándose")
        performSegue(withIdentifier: "goToMainView", sender: self)
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        performLogin()
    }
    
    @IBAction func RegisterButtonAction(_ sender: Any) {
    }
}

