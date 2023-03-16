// 
//  HomeRouter.swift
//  PokemonAPP
//
//  Created by Macbook on 16/03/23.
//

import UIKit

class HomeRouter {
    
    func showView() -> HomeView {
        let interactor = HomeInteractor()
        let presenter = HomePresenter(interactor: interactor)
        let view = HomeView(nibName: String(describing: HomeView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
    func navigateToMyDetailPokemon(navigation: UINavigationController, data: PokemonDetailModel) {
        let vc = MyDetailPokemonRouter().showView()
        vc.dataDetail = data
        vc.hidesBottomBarWhenPushed = true
        navigation.pushViewController(vc, animated: true)
    }
    
}
