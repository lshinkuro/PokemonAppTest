// 
//  HomeInteractor.swift
//  PokemonAPP
//
//  Created by Macbook on 16/03/23.
//

import Foundation
import RxSwift

class HomeInteractor: BaseInteractor {
    
    func fetchPokemon(limit:Int, offset:Int) -> Observable<PokemonModel> {
        api.requestAPI(endpoint: .getListPokemon(limit, offset))
    }
    
    func fectchDetailPokemon(id: Int)  -> Observable<PokemonDetailModel> {
        api.requestAPI(endpoint: .getDetailPokemon(id))
    }
}
