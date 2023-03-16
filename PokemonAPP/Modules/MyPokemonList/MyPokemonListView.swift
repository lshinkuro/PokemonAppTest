// 
//  MyPokemonListView.swift
//  PokemonAPP
//
//  Created by Macbook on 16/03/23.
//

import UIKit

class MyPokemonListView: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.reloadData()
        }
    }
    var presenter: MyPokemonListPresenter?
    var dataPokemon: [PokemonDetailModel] = []


    override func viewDidLoad() {
        super.viewDidLoad()        
        setup()
        loadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
        tableView.reloadData()
    }
    
    func setup() {
        title = "My Pokemon List"
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCellWithNib(PokemonListCell.self)
    }
    
    func loadData() {
        if let pokemon = BaseConstant.userDefaults.data(forKey: "pokemon") {
            do {
                let data = try JSONDecoder().decode([PokemonDetailModel].self, from: pokemon)
                if data.isEmpty {
                    self.dataPokemon = []
                } else {
                    self.dataPokemon = data
                }
            } catch {
                print("Error decoding objects: \(error)")
            }
        } else {
            self.dataPokemon = []
        }
    }
    
    func removeMyPokemon(id: Int) {
        if let index = dataPokemon.firstIndex(where: {  $0.id == id}) {
            dataPokemon.remove(at: index)
        }
        
        if let pokemon = BaseConstant.userDefaults.data(forKey: "pokemon") {
            do {
                var data = try JSONDecoder().decode([PokemonDetailModel].self, from: pokemon)
                
                if let index = data.firstIndex(where: { $0.id == id }) {
                    data.remove(at: index)
                }
                let modifiedData = try JSONEncoder().encode(data)
                BaseConstant.userDefaults.set(modifiedData, forKey: "pokemon")
                tableView.reloadData()

            } catch {
                print("Error decoding/encoding objects: \(error)")
            }
        }
        
    }
    

}

extension MyPokemonListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataPokemon.isEmpty {
          tableView.setEmptyMessage(message: "Tidak Ada Data Pokemon yang di tangkap")
        }else {
          tableView.restore()
        }
        return dataPokemon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = dataPokemon[indexPath.row]
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as PokemonListCell
        cell.setupView(data)
        cell.removeBtn.rx.tap.subscribe(onNext: {[weak self] in
            guard let self = self else { return }
            self.removeMyPokemon(id: data.id)
        }).disposed(by: bag)
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 104
    }
    
    
    
    
}

