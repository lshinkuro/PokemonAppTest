//
//  GradientRoundedButton.swift
//  PokemonAPP
//
//  Created by Macbook on 16/03/23.
//

import Foundation
import UIKit

class GradientRoundedButton: UIButton {
    
    let firstColor =  UIColor.pokemonBrightLinear1
    let secondColor = UIColor.pokemonBrightLinear1
    let startPoint = CGPoint(x: 0, y: 1)
    let endpoint = CGPoint(x: 1, y: 1)
    var gradientLayer: CAGradientLayer!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func draw(_ rect: CGRect) {
        gradientLayer.frame =  rect
        makeCornerRadius(20, maskedCorner: nil)
    }
    
    func setup() {
        gradientLayer = CAGradientLayer()
        gradientLayer.type = .axial
        gradientLayer.colors = [firstColor, secondColor]
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint =  endpoint
        self.layer.addSublayer(gradientLayer)
        
        if let buttonImage = self.imageView {
            self.bringSubviewToFront(buttonImage)
        }
        
        setTitleColor(UIColor.white, for: .normal)
    }
}
