//
//  Endpoint.swift
//  PokemonAPP
//
//  Created by Macbook on 16/03/23.
//

import Foundation
import Alamofire
import RxAlamofire
import RxSwift


enum Endpoint {
    case getListPokemon(Int, Int)
    case getDetailPokemon(Int)
    
    func path() -> String {
        switch self {
        case .getListPokemon:
            return "/pokemon"
        case .getDetailPokemon(let id):
            return "/pokemon/\(id)"
        }
    }
    
    func method() -> HTTPMethod {
        switch self {
        case .getListPokemon:
            return .get
        case .getDetailPokemon(_):
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getListPokemon(let limit, let offset):
            let params: [String: Any] = [
                "limit" : limit,
                "offset" : offset
            ]
            return params
        case .getDetailPokemon(_):
            let params: [String: Any] = [:]
            return params
        }
    }

    var headers: HTTPHeaders {
      switch self {
      case .getListPokemon,
           .getDetailPokemon:
        let params: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        return params
      }
    }

    func urlString() -> String {
      return BaseConstant.baseURL + self.path()
    }
    
}
