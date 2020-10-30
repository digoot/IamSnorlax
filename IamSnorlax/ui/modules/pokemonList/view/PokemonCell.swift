//
//  PokemonCell.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 27/10/2020.
//

import UIKit

final class PokemonCell: UITableViewCell {
    
    static let identifier = String(describing: PokemonCell.self)
    fileprivate static let iconSize: CGFloat = 40

    var pokemonImage = UIImageView()
    var pokemonNameLabel = UILabel()
    var pokemonNumberLabel = UILabel()
    var pokemon: Pokemon? {
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
        contentView.addSubview(pokemonImage)
        contentView.addSubview(pokemonNameLabel)
        contentView.addSubview(pokemonNumberLabel)
        backgroundColor = UIConstants.shared.backgroundColor
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(named: "secondary")
        selectedBackgroundView = backgroundView
    }
    
    fileprivate func setupConstraints() {
        pokemonImage.snp.makeConstraints { make in
            make.width.equalTo(PokemonCell.iconSize)
            make.height.equalTo(PokemonCell.iconSize)
            make.leading.equalToSuperview().offset(5)
            make.centerY.equalToSuperview()
        }
        pokemonNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(pokemonImage.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
        }
        pokemonNumberLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-15)
        }
    }
    
    fileprivate func configureCell() {
        pokemonImage.setImage(with: pokemon?.sprite, placeholder: UIImage(named: "placeholder"))
        pokemonImage.contentMode = .scaleAspectFit
        guard let locale = locale else { return }
        pokemonNameLabel.text = pokemon?.names.filter("locale == %@", locale).first?.value ?? UIConstants.shared.noData
        pokemonNameLabel.font = Font(ofSize: 13).build()
        guard let number = pokemon?.id else { return }
        pokemonNumberLabel.text = "#\(number)"
        pokemonNumberLabel.font = Font(ofSize: 13).build()
    }
    
    func setupInitialState(pokemon: Pokemon, locale: String?) {
        self.locale = locale
        self.pokemon = pokemon
    }
    
    static func buildCell(
        _ tableView: UITableView, cellForRowAt indexPath: IndexPath, pokemon: Pokemon, locale: String?
    ) -> PokemonCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? PokemonCell
        else { return PokemonCell() }
        cell.setupInitialState(pokemon: pokemon, locale: locale)
        return cell
    }

}
