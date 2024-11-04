//
//  WelcomeViewController.swift
//  PruebaPracticaClase
//
//  Created by User-UAM on 11/3/24.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configura el identificador de accesibilidad en la vista principal
        view.accessibilityIdentifier = "mainView"
        
        // Agrega el UILabel como antes
        let welcomeLabel = UILabel()
        welcomeLabel.text = "Welcome to Main View"
        welcomeLabel.textAlignment = .center
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(welcomeLabel)
        
        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
