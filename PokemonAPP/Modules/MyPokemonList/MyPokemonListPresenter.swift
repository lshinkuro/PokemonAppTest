// 
//  MyPokemonListPresenter.swift
//  PokemonAPP
//
//  Created by Macbook on 16/03/23.
//

import Foundation

class MyPokemonListPresenter {
    
    private let interactor: MyPokemonListInteractor
    private let router = MyPokemonListRouter()
    
    init(interactor: MyPokemonListInteractor) {
        self.interactor = interactor
    }
    
}
