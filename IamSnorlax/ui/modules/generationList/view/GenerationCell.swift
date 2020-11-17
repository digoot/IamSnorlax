//
//  GenerationCell.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 25/10/2020.
//

import UIKit

final class GenerationCell: UITableViewCell {
    
    static let identifier = String(describing: GenerationCell.self)

    var name = UILabel()
    var generation: Generation? {
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
        name.text = generation?.names?.filter({ $0.language?.name == locale }).first?.name ?? UIConstants.shared.noData
        name.font = Font(ofSize: 13).build()
    }
    
    func setupInitialState(generation: Generation, locale: String?) {
        self.locale = locale
        self.generation = generation
    }
    
    static func buildCell(
        _ tableView: UITableView, cellForRowAt indexPath: IndexPath, generation: Generation, locale: String?
    ) -> GenerationCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? GenerationCell
        else { return GenerationCell() }
        cell.setupInitialState(generation: generation, locale: locale)
        return cell
    }

}
