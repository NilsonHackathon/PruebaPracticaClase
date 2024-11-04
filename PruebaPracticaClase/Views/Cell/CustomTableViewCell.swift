//
//  CustomTableViewCell.swift
//  PruebaPracticaClase
//
//  Created by User-UAM on 11/4/24.
//

import UIKit

class CustomTableViewCell: UITableViewCell {


    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var fotoView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.accessibilityIdentifier = "customTableVC"
        contentView.layoutIfNeeded()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
