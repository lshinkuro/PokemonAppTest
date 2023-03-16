//
//  RoundedCornerView.swift
//  PokemonAPP
//
//  Created by Macbook on 16/03/23.
//

import Foundation
import UIKit

@IBDesignable
class RoundedCornerView: UIView {

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornerRadius
        layer.shadowOpacity = 0.23
        layer.shadowRadius = 7
        layer.shadowOffset = .zero
        layer.shadowColor = UIColor.gray.cgColor
    }

    @IBInspectable var cornerRadius: CGFloat = 0 {
            didSet {
                layer.cornerRadius = cornerRadius
                layer.masksToBounds = cornerRadius > 0
            }
        }
        
        @IBInspectable var borderWidth: CGFloat = 0 {
            didSet {
                layer.borderWidth = borderWidth
            }
        }
        
        @IBInspectable var borderColor: UIColor? {
            didSet {
                layer.borderColor = borderColor?.cgColor
            }
        }
    
}
