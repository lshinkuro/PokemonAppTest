// 
//  HomePresenter.swift
//  PokemonAPP
//
//  Created by Macbook on 16/03/23.
//

import Foundation
import RxSwift

class HomePresenter {
    
    private let interactor: HomeInteractor
    private let router = HomeRouter()
    
    init(interactor: HomeInteractor) {
        self.interactor = interactor
    }
    
    func getListPokemon(limit: Int, offset: Int) -> Observable<PokemonModel> {
        return interactor.fetchPokemon(limit: limit, offset: offset)
    }
    
    func getDetailPokemon(id: Int) -> Observable<PokemonDetailModel> {
        return interactor.fectchDetailPokemon(id: id)
    }
    
    func navigateToMyDetailPokemon(navigation: UINavigationController, data: PokemonDetailModel) {
        router.navigateToMyDetailPokemon(navigation: navigation, data: data)
    }
    
}
