//
//  WelcomeViewController.swift
//  PruebaPracticaClase
//
//  Created by User-UAM on 11/3/24.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var items: [Item] = [
        Item(text: "Item 1", imageName: "image1"),
        Item(text: "Item 2", imageName: "image2"),
        Item(text: "Item 3", imageName: "image3")
    ]
    
    
    @IBOutlet weak var logoFotoView: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Main"
        //Redondear foto del logo
        logoFotoView.layer.cornerRadius = logoFotoView.bounds.height / 2
                logoFotoView.clipsToBounds = true
        
        // Configura el identificador de accesibilidad en la vista principal
        view.accessibilityIdentifier = "mainView"
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "customTableVC")
        
        // Usa automaticDimension para que la altura se ajuste según el XIB
            //tableView.rowHeight = UITableView.automaticDimension
            //tableView.estimatedRowHeight = 115  // Altura estimada para mejorar rendimiento
        tableView.rowHeight = 115
        
        // Fuerza el layout
            tableView.setNeedsLayout()
            tableView.layoutIfNeeded()
        
        // Configuración de identificadores de accesibilidad
            logoFotoView.accessibilityIdentifier = "logoFotoView"
            tableView.accessibilityIdentifier = "tableView"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "customTableVC", for: indexPath) as? CustomTableViewCell else {
                return UITableViewCell()
            }
            
            let item = items[indexPath.row]
            cell.labelText.text = item.text
            cell.fotoView.image = UIImage(named: item.imageName)
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return items.count
        }
        
        func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            return 10  // Espaciado deseado entre celdas
        }
}

struct Item {
    let text: String
    let imageName: String // Nombre del archivo de imagen en el proyecto
}
