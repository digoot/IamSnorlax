//
//  ErrorView.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 23/11/2020.
//

import UIKit
import SnapKit

class ErrorView: UIView {
    // MARK: - Variables
    
    var image: UIImageView?
    var label: UILabel?
    
    // MARK: - Lifecycle Functions
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupView()
    }
    
    override func didMoveToSuperview() {
        guard let superview = superview else { return }
        self.frame = superview.frame
        self.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Functions
    
    fileprivate func setupView() {
        image = UIImageView()
        label = UILabel()
        image?.image = UIImage(named: "error")
        label?.text = I18n.getString("error")
        label?.textAlignment = .center
        label?.numberOfLines = 0
        label?.font = Font(ofSize: 12).build()
        guard
            let image = image,
            let label = label
        else { return }
        addSubview(image)
        addSubview(label)
        setupConstraints()
    }

    fileprivate func setupConstraints() {
        image?.snp.makeConstraints({ make in
            make.size.equalTo(250)
            make.centerY.equalToSuperview().offset(-150)
            make.centerX.equalToSuperview()
        })
        label?.snp.makeConstraints({ make in
            make.centerY.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
        })
    }
    
    func showIn(_ view: UIView) {
        view.addSubview(self)
    }
    
}
