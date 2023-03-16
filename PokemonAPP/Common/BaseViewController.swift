//
//  BaseViewController.swift
//  PokemonAPP
//
//  Created by Macbook on 16/03/23.
//

import Foundation
import RxSwift

class BaseViewController: UIViewController {
    let bag = DisposeBag()
}

class BaseInteractor {
    var api = ApiManager()
    var bag = DisposeBag()
}
