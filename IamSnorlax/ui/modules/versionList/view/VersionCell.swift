//
//  VersionCell.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 25/10/2020.
//

import UIKit

final class VersionCell: UITableViewCell {
    
    static let identifier = String(describing: VersionCell.self)

    var name = UILabel()
    var version: Version? {
        didSet {
            configureCell()
        }
    }
    var locale: String?
    
    override func didMoveToSuperview() {
        setupView()
        setupConstraints()
    }
    
    // MARK: - Functions
    
    fileprivate func setupView() {
        contentView.addSubview(name)
        backgroundColor = UIConstants.shared.backgroundColor
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(named: "secondary")
        selectedBackgroundView = backgroundView
    }
    
    fileprivate func setupConstraints() {
        name.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(22)
            make.centerY.equalToSuperview()
        }
    }
    
    fileprivate func configureCell() {
        guard let locale = locale else { return }
        name.text = version?.names.filter({ $0.language?.name == locale }).first?.name ?? UIConstants.shared.noData
        name.font = Font(ofSize: 13).build()
    }
    
    func setupInitialState(version: Version, locale: String?) {
        self.locale = locale
        self.version = version
    }
    
    static func buildCell(
        _ tableView: UITableView, cellForRowAt indexPath: IndexPath, version: Version, locale: String?
    ) -> VersionCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? VersionCell
        else { return VersionCell() }
        cell.setupInitialState(version: version, locale: locale)
        return cell
    }

}
