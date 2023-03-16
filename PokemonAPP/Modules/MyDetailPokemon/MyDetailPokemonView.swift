// 
//  MyDetailPokemonView.swift
//  PokemonAPP
//
//  Created by Macbook on 16/03/23.
//

import UIKit
import RxSwift
import Kingfisher

class MyDetailPokemonView: BaseViewController {
 
    
    
    @IBOutlet weak var imagePokemon: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var width: UILabel!
    @IBOutlet weak var hp: UILabel!
    @IBOutlet weak var attack: UILabel!
    @IBOutlet weak var defense: UILabel!
    @IBOutlet weak var specialAttack: UILabel!
    @IBOutlet weak var specialDefense: UILabel!
    @IBOutlet weak var speed: UILabel!
    @IBOutlet weak var pokemonType: UILabel!
    @IBOutlet weak var pokemonAbility: UILabel!
   
    @IBOutlet weak var catchBtn: GradientRoundedButton!
    
    var presenter: MyDetailPokemonPresenter?
    var dataDetail: PokemonDetailModel?
    var dataMyPokemon: PokemonDetailModel?
    var imageUrl = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail Pokemon"
        setupView()
        setupAction()
        checkMyPokemon()
    }
    
    func setupAction() {
        catchBtn.rx.tap.subscribe { _ in
            self.catchPokemon()
        }.disposed(by: bag)
    }
    
    func checkMyPokemon() {
        if let pokemon = BaseConstant.userDefaults.data(forKey: "pokemon") {
            do {
                let data = try JSONDecoder().decode([PokemonDetailModel].self, from: pokemon)
                for item in data {
                    if item.id == dataDetail?.id {
                        catchBtn.isHidden = true
                    }
                }
            } catch {
                print("Error decoding objects: \(error)")
            }
        }
    }
    
    func showAlert() {
        let message =  "Failed to Catch Pokemon"
        let title = "Failed"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.dismiss(animated: true)
        }
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func catchPokemon() {
        let randomCatch = Bool.random()
        if randomCatch {
            showPopupNickname()
        } else {
            showAlert()
        }
    }
    
    func showPopupNickname() {
        guard let nav = self.navigationController else { return  }
        let vc = PopUpAddList()
        vc.delegate = self
        vc.imageUrl = imageUrl
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .coverVertical
        nav.present(vc, animated: true)
    }
    
    func savePokemon() {
        guard let dataPokemon = dataMyPokemon else { return  }
        if let encodedObjects =  BaseConstant.userDefaults.data(forKey: "pokemon") {
            do {
                var objects = try JSONDecoder().decode([PokemonDetailModel].self, from: encodedObjects)
                objects.append(dataPokemon)
                
                let updatedEncodedObjects = try JSONEncoder().encode(objects)
                BaseConstant.userDefaults.set(updatedEncodedObjects, forKey: "pokemon")
                BaseConstant.userDefaults.synchronize()
                catchBtn.isHidden = true
            } catch {
                print("Error decoding/encoding : \(error)")
            }
        } else {
            let myPokemon = [dataPokemon]
            do {
                let encodedObjects = try JSONEncoder().encode(myPokemon)
                BaseConstant.userDefaults.set(encodedObjects, forKey: "pokemon")
                BaseConstant.userDefaults.synchronize()
                catchBtn.isHidden = true
            } catch {
                print("Error encoding : \(error)")
            }
        }
    }
    


}

extension MyDetailPokemonView {
    func setupView() {
        guard let data = dataDetail else { return  }
        imageUrl = data.sprites.other?.home.frontDefault ?? ""
        let imageUrl = URL(string: data.sprites.other?.home.frontDefault ?? "")
        imagePokemon.kf.setImage(with: imageUrl)
        nameLbl.text = data.name
        height.text = "Height : \(data.height)"
        width.text = "Width : \(data.weight)"
        
        for item in data.stats {
            switch PokemonStatsName(rawValue: item.stat.name) {
            case .Hp :
                hp.text = "Hp : \(item.baseStat)"
            case .Attack:
                attack.text = "Attack : \(item.baseStat)"
            case .Defense:
                defense.text = "Defense : \(item.baseStat)"
            case .SpecialAttack:
                specialAttack.text = "Special Attack : \(item.baseStat)"
            case .SpecialDefense:
                specialDefense.text = "Special Defense : \(item.baseStat)"
            case .Speed:
                speed.text = "Speed : \(item.baseStat)"
            default:
                break
            }
        }
        
        for item in data.types {
            switch item.slot {
            case 1:
                pokemonType.text = "Element : \(item.type.name)"
            case 2:
                pokemonAbility.text = "Ability : \(item.type.name)"
            default:
                break
            }
        }
    }
}

extension MyDetailPokemonView: PopupAddNameDelegate {
    func getName(name: String) {
        guard var data = dataDetail else { return  }
        data.nickNames = name
        dataMyPokemon = data
        savePokemon()
    }
}
