//
//  VersionCell.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 25/10/2020.
//

import UIKit

final class VersionCell: UITableViewCell {
    
    static let identifier = String(describing: GenerationCell.self)

    var name = UILabel()
    var generation: Generation? {
        didSet {
            configureCell()
        }
    }
    
    override func didMoveToSuperview() {
        setupView()
        setupConstraints()
    }
    
    // MARK: - Functions
    
    fileprivate func setupView() {
        contentView.addSubview(name)
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(named: "secondary-light")
        selectedBackgroundView = backgroundView
    }
    
    fileprivate func setupConstraints() {
        name.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(22)
            make.centerY.equalToSuperview()
        }
    }
    
    fileprivate func configureCell() {
        guard let languageCode = NSLocale.current.languageCode else { return }
        name.text = generation?.names.filter("locale == %@", languageCode).first?.value
        name.font = UIFont(name: "pokemon-font", size: 13)
    }
    
    func setupInitialState(generation: Generation) {
        self.generation = generation
    }
    
    static func buildCell(
        _ tableView: UITableView, cellForRowAt indexPath: IndexPath, generation: Generation
    ) -> GenerationCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? GenerationCell
        else { return GenerationCell() }
        cell.setupInitialState(generation: generation)
        return cell
    }

}
