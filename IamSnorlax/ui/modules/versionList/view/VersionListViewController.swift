//
//  VersionListViewController.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 24/10/2020.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SnapKit

class VersionListViewController: UIViewController {
    
    // MARK: Variables
    
    var presenter: ViewToPresenterVersionListProtocol?
    var versionTable: UITableView? {
        didSet {
            versionTable?.register(VersionCell.self, forCellReuseIdentifier: VersionCell.identifier)
            versionTable?.rx.setDelegate(self).disposed(by: disposeBag)
            versionTable?.rx.setDataSource(self).disposed(by: disposeBag)
        }
    }
    let activityIndicator = UIActivityIndicatorView()
    var dataSource: [Version]?
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
    
    // MARK: Functions
    
    func setupView() {
        title = I18n.getString("game versions")
        navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        view.backgroundColor = UIConstants.shared.backgroundColor
        versionTable = UITableView()
        versionTable?.tableFooterView = UIView()
        versionTable?.backgroundColor = UIConstants.shared.backgroundColor
        versionTable?.separatorColor = UIColor(named: "separator-color")
        refreshController.addTarget(self, action: #selector(refresh), for: .valueChanged)
        versionTable?.refreshControl = refreshController
        guard let versionTable = versionTable else { return }
        startIndicator(table: versionTable)
        view.addSubview(versionTable)
        setupConstraints()
        setupBindings()
    }
    
    fileprivate func setupConstraints() {
        versionTable?.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    fileprivate func setupBindings() {
        setupVersionsBinding()
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
        setupVersionsBinding()
        presenter?.viewIsReady()
        refreshController.endRefreshing()
    }
}

// MARK: - Setup bindings
 
extension VersionListViewController {
    fileprivate func setupVersionsBinding() {
        presenter?.versions.subscribe(onNext: { versions in
            self.stopIndicator()
            self.dataSource = versions?.sorted(by: { lhs, rhs -> Bool in
                lhs.id < rhs.id
            })
            self.versionTable?.reloadData()
        }).disposed(by: disposeBag)
    }
}

// MARK: - Presenter Delegate

extension VersionListViewController: PresenterToViewVersionListProtocol {
    
}

// MARK: - UITableView Delegates

extension VersionListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let version = dataSource?[indexPath.row] else { return VersionCell() }
        return VersionCell.buildCell(tableView, cellForRowAt: indexPath, version: version, locale: locale)
    }
}

extension VersionListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let version = dataSource?[indexPath.row] else { return }
        presenter?.navigateToPokemonList(version: version)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
