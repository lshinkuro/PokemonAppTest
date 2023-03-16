//
//  BaseConstant.swift
//  PokemonAPP
//
//  Created by Macbook on 16/03/23.
//

import Foundation
import UIKit

struct BaseConstant {
    static let baseURL = "https://pokeapi.co/api/v2"
    static let userDefaults = UserDefaults.standard
}

enum SFSymbols {
    static let homeSymbol = UIImage(named: "pokemon-64")
    static let orderSymbol = UIImage(named: "star-pokemon-48")
    
    static let arrowSymbol = UIImage(systemName: "arrow.right.circle.fill")
    static let statusSymbol = UIImage(systemName: "circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 8, weight: .regular, scale: .default))
}

enum ScreenSize {
    static let width        = UIScreen.main.bounds.size.width
    static let height       = UIScreen.main.bounds.size.height
    static let maxLength    = max(ScreenSize.width, ScreenSize.height)
    static let minLength    = min(ScreenSize.width, ScreenSize.height)
}

extension CGFloat {
    static let currentDeviceWidth  = UIScreen.main.bounds.width
    static let currentDeviceHeight = UIScreen.main.bounds.height
}
