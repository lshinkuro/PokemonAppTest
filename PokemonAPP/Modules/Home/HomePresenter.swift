// 
//  HomePresenter.swift
//  PokemonAPP
//
//  Created by Macbook on 16/03/23.
//

import Foundation

class HomePresenter {
    
    private let interactor: HomeInteractor
    private let router = HomeRouter()
    
    init(interactor: HomeInteractor) {
        self.interactor = interactor
    }
    
}
