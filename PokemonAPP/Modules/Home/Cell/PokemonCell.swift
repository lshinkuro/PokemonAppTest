//
//  PokemonCell.swift
//  PokemonAPP
//
//  Created by Macbook on 16/03/23.
//

import UIKit
import Kingfisher

class PokemonCell: UITableViewCell {

    @IBOutlet weak var labelTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func setupData() {
        print("setup data")
    }
    
}
