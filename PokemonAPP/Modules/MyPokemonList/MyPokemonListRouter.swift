// 
//  MyPokemonListRouter.swift
//  PokemonAPP
//
//  Created by Macbook on 16/03/23.
//

import UIKit

class MyPokemonListRouter {
    
    func showView() -> MyPokemonListView {
        let interactor = MyPokemonListInteractor()
        let presenter = MyPokemonListPresenter(interactor: interactor)
        let view = MyPokemonListView(nibName: String(describing: MyPokemonListView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
    //Navigate to other xib-based router
    /*
    func navigateToOtherView(from navigation: UINavigationController, with data: Any) {
        let otherView = OtherViewRouter().showView(with: data)
        navigation.pushViewController(otherView, animated: true)
    }
    */
    
    //Navigate to other storyboard-based router
    /*
    func navigateToOtherView(from navigation: UINavigationController, with data: Any) {
        let otherView = OtherViewRouter().showView(with: data)
        navigation.pushViewController(otherView, animated: true)
    }
     */
    
}
