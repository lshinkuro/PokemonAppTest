// 
//  MyDetailPokemonRouter.swift
//  PokemonAPP
//
//  Created by Macbook on 16/03/23.
//

import UIKit

class MyDetailPokemonRouter {
    
    func showView() -> MyDetailPokemonView {
        let interactor = MyDetailPokemonInteractor()
        let presenter = MyDetailPokemonPresenter(interactor: interactor)
        let view = MyDetailPokemonView(nibName: String(describing: MyDetailPokemonView.self), bundle: nil)
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
