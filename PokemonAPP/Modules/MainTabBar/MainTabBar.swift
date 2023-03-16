//
//  MainTabBar.swift
//  PokemonAPP
//
//  Created by Macbook on 16/03/23.
//

import Foundation
import UIKit

class MainTabBarViewController: UITabBarController {

  let homeVC = UINavigationController(rootViewController: HomeRouter().showView() )
    let myListPokemonVC = UINavigationController(rootViewController: MyPokemonListRouter().showView())

  override func viewDidLoad() {
      super.viewDidLoad()
      configureTabBar()
      configureUITabBarItems()
      self.tabBar.backgroundColor = UIColor.yellow

  }

  func configureUITabBarItems(){
      homeVC.tabBarItem = UITabBarItem(title: "Home", image: SFSymbols.homeSymbol, tag: 0)
      myListPokemonVC.tabBarItem = UITabBarItem(title: "MyList", image:  SFSymbols.orderSymbol, tag: 1)
  }

  func configureTabBar(){
    setViewControllers([homeVC, myListPokemonVC], animated: true)
  }
}
