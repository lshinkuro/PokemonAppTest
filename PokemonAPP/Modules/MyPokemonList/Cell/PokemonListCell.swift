//
//  PokemonListCell.swift
//  PokemonAPP
//
//  Created by Macbook on 16/03/23.
//

import UIKit

class PokemonListCell: UITableViewCell {
    
    @IBOutlet weak var labelImage: UIImageView!    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelNickname: UILabel!
    @IBOutlet weak var removeBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupView(_ dataPokemon: PokemonDetailModel?) {
        guard let data = dataPokemon else {return}
        let imageUrl = URL(string: data.sprites.frontDefault ?? "")
        removeBtn.isHidden = false
        labelName.text = data.name
        labelNickname.text = "Nickname : \(data.nickNames ?? "")"
        labelImage.kf.setImage(with: imageUrl)
    }
    
}
