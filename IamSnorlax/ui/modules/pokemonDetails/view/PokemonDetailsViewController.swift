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
    
    // MARK: Outlets
    
    // MARK: Life cycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.viewIsReady()
    }
    
    // MARK: Functions
    
    func setupView() {
        guard
            let pokemon = presenter?.pokemon,
            let locale = UIConstants.shared.locale
        else { return }
        title = pokemon.names.filter("locale == %@", locale).first?.value
        navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
//        view.backgroundColor = UIColor(named: "secondary-light")
        view.backgroundColor = UIConstants.shared.backgroundColor
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        verticalStack.alignment = .leading
        verticalStack.axis = .vertical
        verticalStack.spacing = 20
        scrollView.addSubview(verticalStack)
        verticalStack.addArrangedSubview(pokemonDescriptionLabel)
        imageView.setImage(with: presenter?.pokemon?.image, placeholder: UIImage(named: "placeholder"))
        imageView.backgroundColor = UIColor(named: "primary-light")
        pokemonDescriptionLabel.text = pokemon.wording
        pokemonDescriptionLabel.numberOfLines = 0
        pokemonDescriptionLabel.font = Font(ofSize: 15).build()
        if pokemon.baby {
            verticalStack.addArrangedSubview(babyLabel)
            babyLabel.text = I18n.getString("baby.label")
        }
        if pokemon.legendary {
            verticalStack.addArrangedSubview(legendaryLabel)
            legendaryLabel.text = I18n.getString("legendary.label")
        }
        if pokemon.mythical {
            verticalStack.addArrangedSubview(mythicalLabel)
            mythicalLabel.text = I18n.getString("mythical.label")
        }
        babyLabel.font = font
        babyLabel.textColor = UIColor.red
        legendaryLabel.font = font
        legendaryLabel.textColor = UIColor.red
        mythicalLabel.font = font
        mythicalLabel.textColor = UIColor.red
        heightLabel.font = font
        weightLabel.font = font
        baseExperienceLabel.font = font
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
    
    fileprivate func setupBindings() {
        setupPokemonsBinding()
    }
}

// MARK: - Setup bindings
 
extension PokemonDetailsViewController {
    fileprivate func setupPokemonsBinding() {
        presenter?.fetchedInfo.subscribe(onNext: { pokemon in
            guard let pokemon = pokemon else { return }
            self.heightLabel.text = I18n.getString("height.label", CGFloat(pokemon.height) / 10)
            self.verticalStack.addArrangedSubview(self.heightLabel)
            self.weightLabel.text = I18n.getString("weight.label", CGFloat(pokemon.weight) / 10)
            self.verticalStack.addArrangedSubview(self.weightLabel)
            self.baseExperienceLabel.text = I18n.getString("baseExperience.label", pokemon.baseExperience)
            self.verticalStack.addArrangedSubview(self.baseExperienceLabel)
        }).disposed(by: disposeBag)
    }
}

extension PokemonDetailsViewController: PresenterToViewPokemonDetailsProtocol {
    
}
