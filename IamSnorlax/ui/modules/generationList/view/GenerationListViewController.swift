//
//  GenerationListViewController.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 22/10/2020.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SnapKit

class GenerationListViewController: UIViewController {
    
    // MARK: - Variables
    
    var presenter: ViewToPresenterGenerationListProtocol?
    var generationTable: UITableView? {
        didSet {
            generationTable?.register(GenerationCell.self, forCellReuseIdentifier: GenerationCell.identifier)
            generationTable?.rx.setDelegate(self).disposed(by: disposeBag)
            generationTable?.rx.setDataSource(self).disposed(by: disposeBag)
        }
    }
    let activityIndicator = UIActivityIndicatorView()
    var dataSource: [Generation]?
    let disposeBag = DisposeBag()
    let refreshController = UIRefreshControl()
    let locale = UIConstants.shared.locale
    
    // MARK: Outlets
    
    // MARK: Life cycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.viewIsReady()
    }
    
    // MARK: - Functions
    
    func setupView() {
        title = I18n.getString("generations")
        navigationController?.navigationBar.tintColor = UIColor(named: "nav-tint")
        navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        navigationController?.navigationBar.backItem?.title = ""
        view.backgroundColor = UIConstants.shared.backgroundColor
        generationTable = UITableView()
        generationTable?.tableFooterView = UIView()
        generationTable?.backgroundColor = UIConstants.shared.backgroundColor
        generationTable?.separatorColor = UIColor(named: "separator-color")
        refreshController.addTarget(self, action: #selector(refresh), for: .valueChanged)
        generationTable?.refreshControl = refreshController
        guard let generationTable = generationTable else { return }
        startIndicator(table: generationTable)
        view.addSubview(generationTable)
        setupConstraints()
        setupBindings()
    }
    
    fileprivate func setupConstraints() {
        generationTable?.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    fileprivate func setupBindings() {
        setupGenerationsBinding()
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
    
    @objc func refresh() {
        refreshController.beginRefreshing()
        setupGenerationsBinding()
        presenter?.viewIsReady()
        refreshController.endRefreshing()
    }
}

// MARK: - Setup bindings
 
extension GenerationListViewController {
    fileprivate func setupGenerationsBinding() {
        presenter?.generations.subscribe(onNext: { generations in
            self.stopIndicator()
            self.dataSource = generations?.sorted(by: { lhs, rhs -> Bool in
                lhs.id < rhs.id
            })
            self.generationTable?.reloadData()
        }).disposed(by: disposeBag)
    }
}

// MARK: - Presenter Delegate

extension GenerationListViewController: PresenterToViewGenerationListProtocol {
    
}

// MARK: - UITableView Delegates

extension GenerationListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let generation = dataSource?[indexPath.row] else { return GenerationCell() }
        return GenerationCell.buildCell(tableView, cellForRowAt: indexPath, generation: generation, locale: locale)
    }
}

extension GenerationListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let generation = dataSource?[indexPath.row] else { return }
        presenter?.navigateToVersionList(generation: generation)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
