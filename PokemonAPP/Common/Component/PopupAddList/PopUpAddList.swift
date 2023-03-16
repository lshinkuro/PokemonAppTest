//
//  PopUpAddList.swift
//  PokemonAPP
//
//  Created by Macbook on 16/03/23.
//

import UIKit
import Kingfisher

protocol PopupAddNameDelegate {
    func getName(name: String)
   
}

class PopUpAddList: BasePopUpViewController {
    
    @IBOutlet weak var viewCoachmark: UIView!
    @IBOutlet weak var viewInfo: UIView!
    @IBOutlet weak var imageField: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var btnBack: GradientRoundedButton!
    @IBOutlet weak var btnOk: GradientRoundedButton!
    
    var delegate: PopupAddNameDelegate?
    var isDismissBackview: Bool = true
    var imageUrl = ""


    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        didLoadPopup(backView: viewCoachmark, contentView: viewInfo)
        setupView()
        setupAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateContainerUp(viewInfo)
    }

    func setupAction() {
        btnBack.rx.tap.subscribe({ [weak self] _ in
            guard let self = self else { return }
            let newName = self.nameTextField.text ?? ""
            self.dismiss(animated: true, completion: nil)
        }).disposed(by: bag)
        
        btnOk.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            let newName = self.nameTextField.text ?? ""
            self.delegate?.getName(name: newName)
            self.dismiss(animated: true, completion: nil)
        }).disposed(by: bag)

    }
    
    func setupView() {
        viewInfo.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        viewInfo.layer.cornerRadius = 20
        let imageUrl = URL(string: imageUrl)
        imageField.kf.setImage(with: imageUrl)
    }
    
    func animatePopUp() {
        UIViewPropertyAnimator(
            duration: 0.5,
            dampingRatio: 0.5) { [weak viewInfo] () in
                viewInfo?.transform = .identity
            } .startAnimation()
    }
}
