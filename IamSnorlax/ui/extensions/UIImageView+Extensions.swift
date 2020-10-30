//
//  UIImageView+Extensions.swift
//  Dogoplay
//
//  Created by Diego Otero Mata on 18/05/2020.
//  Copyright © 2020 Cleventy. All rights reserved.
//

import UIKit

extension UIImageView {
    func setImage(with url: String?, placeholder: UIImage?, cacheKey: String? = nil) {
        ImageManager.shared.setImage(to: self, with: url, placeholder: placeholder,
                                     cacheKey: cacheKey)
    }
}
