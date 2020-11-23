//
//  PokemonListViewController.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 26/10/2020.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SnapKit

class PokemonListViewController: UIViewController {
    
    // MARK: Variables
    
    var presenter: ViewToPresenterPokemonListProtocol?
    var pokemonTable: UITableView? {
        didSet {
            pokemonTable?.register(PokemonCell.self, forCellReuseIdentifier: PokemonCell.identifier)
            pokemonTable?.rx.setDelegate(self).disposed(by: disposeBag)
            pokemonTable?.rx.setDataSource(self).disposed(by: disposeBag)
            pokemonTable?.rx.setPrefetchDataSource(self).disposed(by: disposeBag)
        }
    }
    let activityIndicator = UIActivityIndicatorView()
    var dataSource = [PokemonSpecie]()
    let disposeBag = DisposeBag()
    let refreshController = UIRefreshControl()
    let locale = UIConstants.shared.locale
    var disposable: Disposable?
    
    // MARK: Outlets
    
    // MARK: Life cycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.viewIsReady()
    }
    
    deinit {
        disposable?.disposed(by: disposeBag)
    }
    
    // MARK: Functions
    
    func setupView() {
        title = I18n.getString("pokemons")
        navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        view.backgroundColor = UIConstants.shared.backgroundColor
        pokemonTable = UITableView()
        pokemonTable?.tableFooterView = UIView()
        pokemonTable?.backgroundColor = UIConstants.shared.backgroundColor
        pokemonTable?.separatorColor = UIColor(named: "separator-color")
        pokemonTable?.separatorInset = UIEdgeInsets(top: 0, left: 52, bottom: 0, right: 0)
        guard let pokemonTable = pokemonTable else { return }
        startIndicator(table: pokemonTable)
        view.addSubview(pokemonTable)
        setupConstraints()
        setupBindings()
    }
    
    fileprivate func setupConstraints() {
        pokemonTable?.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    fileprivate func setupBindings() {
        setupPokemonsBinding()
    }
    
    fileprivate func startIndicator(table: UITableView) {
        activityIndicator.frame = table.bounds
        activityIndicator.style = .large
        activityIndicator.startAnimating()
        table.backgroundView = activityIndicator
    }
    
    fileprivate func stopIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
}

// MARK: - Setup bindings
 
extension PokemonListViewController {
    fileprivate func setupPokemonsBinding() {
        presenter?.pokemons.subscribe(onNext: { pokemons in
            self.stopIndicator()
            guard var pokemons = pokemons else { return }
            pokemons = pokemons.sorted { lhs, rhs -> Bool in
                lhs.id < rhs.id
            }
            self.dataSource.append(contentsOf: pokemons)
            self.pokemonTable?.reloadData()
        }, onError: { _ in
            self.stopIndicator()
            ErrorView().showIn(self.view)
        }).disposed(by: disposeBag)
    }
}

extension PokemonListViewController: PresenterToViewPokemonListProtocol {
    
}

// MARK: - UITableView Delegates

extension PokemonListViewController: UITableViewDataSourcePrefetching {
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= dataSource.count - 1
    }
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            guard let lastRow = indexPaths.last?.row else { return }
            let page = Int(round(Double(lastRow / (UIConstants.shared.pokemonsPerPage - 1)))) + 1
            DispatchQueue.main.async {
                self.presenter?.pokemons = PublishSubject()
                self.setupPokemonsBinding()
                self.presenter?.loadPokemons(page: page)
            }
        }
    }
}

extension PokemonListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pokemon = dataSource[indexPath.row]
        return PokemonCell.buildCell(tableView, cellForRowAt: indexPath, pokemon: pokemon, locale: locale)
    }
}

extension PokemonListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pokemon = dataSource[indexPath.row]
        presenter?.navigateToPokemonDetails(pokemon: pokemon)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
