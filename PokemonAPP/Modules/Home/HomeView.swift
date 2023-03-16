// 
//  HomeView.swift
//  PokemonAPP
//
//  Created by Macbook on 16/03/23.
//

import UIKit
import RxSwift

class HomeView: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
        
    lazy var loadingIndicator = PopUpLoading(on: view)
    let subject = PublishSubject<PokemonModel>()
    var presenter: HomePresenter?
    var dataPokemon: [ResultList] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    var dataDetailPokemon: PokemonDetailModel? {
        didSet {
            self.tableView.allowsSelection = true
        }
    }
    var page = 0
        
    override func viewWillAppear(_ animated: Bool) {
        title = "List Pokemon"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadData()
        
        subject.subscribe(onNext: { [weak self] data in
            guard let self = self else { return }
            self.dataPokemon.append(contentsOf: data.results)
        }).disposed(by: bag)
    }
    
    func setup() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCellWithNib(PokemonCell.self)

    }
    
    func loadData() {
        loadingIndicator.show()
        if let presenter = self.presenter {
            presenter.getListPokemon(limit: 10, offset: page)
                .subscribe { (data: PokemonModel) in
                    self.loadingIndicator.dismissAfter1()
                    self.subject.onNext(data)
                } onError: { error in
                    self.subject.onError(error)
                }.disposed(by: bag)
        }
    }
    
    func loadMoreData() {
        loadingIndicator.show()
        page += 10
        if let presenter = self.presenter {
            presenter.getListPokemon(limit: 10, offset: page)
                .take(1)
                .subscribe { (data: PokemonModel) in
                    self.loadingIndicator.dismissAfter1()
                    self.subject.onNext(data)
                } onError: { error in
                    self.subject.onError(error)
                }.disposed(by: bag)
        }
    }
    
    func getDetailPokemon(id: Int) {
        if let presenter = self.presenter {
            presenter.getDetailPokemon(id: id)
                .take(1)
                .subscribe(onNext: { [weak self] data in
                    guard let self = self else { return }
                    self.dataDetailPokemon = data
                    self.navigateToDetailPokemon()
                }).disposed(by: bag)
        }
        
    }
    
    func navigateToDetailPokemon() {
        guard let data = dataDetailPokemon else { return }
        guard let presenter = self.presenter else { return }
        guard let navigation = self.navigationController else { return }
        presenter.navigateToMyDetailPokemon(navigation: navigation, data: data)
    }

}

extension HomeView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataPokemon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = dataPokemon[indexPath.item]
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as PokemonCell
        cell.labelTitle.text =  data.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = dataPokemon[indexPath.item]
        let urlString = data.url
        let components = urlString.split(separator: "/")
        let lastComponent = components.last ?? "0"
        let lastInt = Int(lastComponent)
        getDetailPokemon(id: lastInt ?? 0)
    }

    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == dataPokemon.count - 1 {
            loadMoreData()
        }
    }
    
   
}


