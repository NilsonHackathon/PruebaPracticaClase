//
//  RegisterViewController.swift
//  PruebaPracticaClase
//
//  Created by User-UAM on 11/5/24.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var userIDTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var secondPassTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.accessibilityIdentifier = "register_nameTextField"
        userIDTextField.accessibilityIdentifier = "register_userIDTextField"
        phoneTextField.accessibilityIdentifier = "register_phoneTextField"
        passwordTextField.accessibilityIdentifier = "register_passwordTextField"
        secondPassTextField.accessibilityIdentifier = "register_secondPassTextField"
        registerButton.accessibilityIdentifier = "register_registerButton"
        
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert.view.accessibilityIdentifier = "errorAlert"
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func registerAction(_ sender: UIButton){
        //Validar contraseña
        guard let password = passwordTextField.text,
              let secondPassword = secondPassTextField.text,
              password == secondPassword
        else{
            showAlert(message: "Las contraseñas no coinciden.")
            return
        }
        
        guard let name = nameTextField.text, !name.isEmpty,
              let userID = userIDTextField.text, !userID.isEmpty,
              let phone = phoneTextField.text, !phone.isEmpty
        else {
            showAlert(message: "Por favor, complete todos los campos.")
            return
        }
        
        let newUser = User(name: name, userID: userID, phone: phone)
        
        NotificationCenter.default.post(name: NSNotification.Name("NewUserRegistered"), object: newUser)
        
        // Mostrar alerta de éxito en lugar de navegar
        let successAlert = UIAlertController(title: "Éxito", message: "Datos guardados correctamente.", preferredStyle: .alert)
        successAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        successAlert.view.accessibilityIdentifier = "successAlert"
        self.present(successAlert, animated: true, completion: nil)
        
        // Cerrar la vista de registro
        /*if self.navigationController != nil {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }*/
    }
    
}

// Estructura para almacenar el usuario
struct User {
    let name: String
    let userID: String
    let phone: String
}
