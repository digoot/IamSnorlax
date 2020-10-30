//
//  UIImageView+Extensions.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 18/05/2020.
//

import UIKit

extension UIImageView {
    func setImage(with url: String?, placeholder: UIImage?, cacheKey: String? = nil) {
        ImageManager.shared.setImage(to: self, with: url, placeholder: placeholder,
                                     cacheKey: cacheKey)
    }
}
