//
//  PokemonDetailsViewController.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 28/10/2020.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SnapKit

class PokemonDetailsViewController: UIViewController {
    
    // MARK: Variables
    
    var presenter: ViewToPresenterPokemonDetailsProtocol?
    var scrollView = UIScrollView()
    var imageView = UIImageView()
    var verticalStack = UIStackView()
    var pokemonDescriptionLabel = UILabel()
    var babyLabel = UILabel()
    var legendaryLabel = UILabel()
    var mythicalLabel = UILabel()
    var heightLabel = UILabel()
    var weightLabel = UILabel()
    var baseExperienceLabel = UILabel()
    var disposeBag = DisposeBag()
    let font = Font(ofSize: 15).build()
    let backgroundIndicator = UIView()
    let activityIndicator = UIActivityIndicatorView()
    
    // MARK: Outlets
    
    // MARK: Life cycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.viewIsReady()
    }
    
    // MARK: Functions
    
    fileprivate func setupView() {
        guard
            let pokemon = presenter?.pokemon,
            let locale = UIConstants.shared.locale
        else { return }
        title = pokemon.names.filter({ $0.language?.name == locale }).first?.name ?? UIConstants.shared.noData
        navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        view.backgroundColor = UIConstants.shared.backgroundColor
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        verticalStack.alignment = .leading
        verticalStack.axis = .vertical
        verticalStack.spacing = 20
        scrollView.addSubview(verticalStack)
        verticalStack.addArrangedSubview(pokemonDescriptionLabel)
        imageView.backgroundColor = UIColor(named: "primary-light")
        pokemonDescriptionLabel.numberOfLines = 0
        pokemonDescriptionLabel.font = Font(ofSize: 15).build()
        babyLabel.font = font
        babyLabel.textColor = UIColor.red
        legendaryLabel.font = font
        legendaryLabel.textColor = UIColor.red
        mythicalLabel.font = font
        mythicalLabel.textColor = UIColor.red
        heightLabel.font = font
        weightLabel.font = font
        baseExperienceLabel.font = font
        backgroundIndicator.frame = view.frame
        backgroundIndicator.backgroundColor = UIConstants.shared.backgroundColor
        startIndicator(view: view)
        setupConstraints()
        setupBindings()
    }
    
    fileprivate func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(imageView.snp.width)
        }
        verticalStack.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.trailing.equalToSuperview().offset(-15)
            make.leading.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
        }
    }
    
    fileprivate func setupData(pokemon: Pokemon) {
        guard let locale = UIConstants.shared.locale else { return }
        imageView.setImage(
            with: pokemon.sprites?.other?.artWork?.frontDefault?.absoluteString,
            placeholder: UIImage(named: "placeholder")
        )
        pokemonDescriptionLabel.text = presenter?.pokemon?.descriptions.filter({ $0.language?.name == locale }).first?.text
        heightLabel.text = I18n.getString("height.label", CGFloat(pokemon.height ?? 0) / 10)
        verticalStack.addArrangedSubview(self.heightLabel)
        weightLabel.text = I18n.getString("weight.label", CGFloat(pokemon.weight ?? 0) / 10)
        verticalStack.addArrangedSubview(self.weightLabel)
        baseExperienceLabel.text = I18n.getString("baseExperience.label", pokemon.baseExperience ?? 0)
        verticalStack.addArrangedSubview(self.baseExperienceLabel)
        if let isBaby = presenter?.pokemon?.baby, isBaby {
            verticalStack.addArrangedSubview(babyLabel)
            babyLabel.text = I18n.getString("baby.label")
        }
        if let isLegendary = presenter?.pokemon?.legendary, isLegendary {
            verticalStack.addArrangedSubview(legendaryLabel)
            legendaryLabel.text = I18n.getString("legendary.label")
        }
        if let isMythical = presenter?.pokemon?.mythical, isMythical {
            verticalStack.addArrangedSubview(mythicalLabel)
            mythicalLabel.text = I18n.getString("mythical.label")
        }
    }
    
    fileprivate func startIndicator(view: UIView) {
        activityIndicator.frame = view.frame
        activityIndicator.style = .large
        activityIndicator.startAnimating()
        view.addSubview(backgroundIndicator)
        view.addSubview(activityIndicator)
    }
    
    fileprivate func stopIndicator() {
        activityIndicator.stopAnimating()
        backgroundIndicator.removeFromSuperview()
        activityIndicator.removeFromSuperview()
    }
    
    fileprivate func setupBindings() {
        setupPokemonsBinding()
    }
}

// MARK: - Setup bindings
 
extension PokemonDetailsViewController {
    fileprivate func setupPokemonsBinding() {
        presenter?.fetchedInfo.subscribe(onNext: { pokemon in
            guard let pokemon = pokemon else { return }
            self.stopIndicator()
            self.setupData(pokemon: pokemon)
        }, onError: { _ in
            self.stopIndicator()
            self.view.addSubview(self.backgroundIndicator)
            ErrorView().showIn(self.view)
        }).disposed(by: disposeBag)
    }
}

extension PokemonDetailsViewController: PresenterToViewPokemonDetailsProtocol {
    
}
