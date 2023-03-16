// 
//  MyDetailPokemonPresenter.swift
//  PokemonAPP
//
//  Created by Macbook on 16/03/23.
//

import Foundation

class MyDetailPokemonPresenter {
    
    private let interactor: MyDetailPokemonInteractor
    private let router = MyDetailPokemonRouter()
    
    init(interactor: MyDetailPokemonInteractor) {
        self.interactor = interactor
    }
    
}
