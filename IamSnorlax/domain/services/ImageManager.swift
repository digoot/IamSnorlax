//
//  ImageManager.swift
//  Dogoplay
//
//  Created by Diego Otero Mata on 18/05/2020.
//  Copyright © 2020 Cleventy. All rights reserved.
//

import Kingfisher

class ImageManager {
    static let shared = ImageManager()
    let cache = ImageCache(name: "DogoplayImages")
    let options: KingfisherOptionsInfo?

    private init() {
        cache.memoryStorage.config.totalCostLimit = 200 * 1024 * 1024
        options = [.transition(.fade(0.25)), .targetCache(cache)]
    }

    func setImage(to component: UIImageView, with url: String?, placeholder: UIImage?,
                  cacheKey: String? = nil) {
        var imageResource: ImageResource?
        if let _url = url, let url = URL(string: _url) {
            imageResource = ImageResource(downloadURL: url, cacheKey: cacheKey)
        }
        component.kf.setImage(with: imageResource, placeholder: placeholder, options: options,
                              completionHandler: { result in
                                  switch result {
                                      case let .success(value):
                                          Log.print.info(
                                              "Image retrieved from: " +
                                                  "\(value.originalSource.url?.absoluteString ?? "Unknown source")")
                                      case let .failure(error):
                                          Log.print.warning(error.localizedDescription)
                                  }
        })
    }

    func setImage(to component: UIButton, with url: String?, placeholder: UIImage?,
                  for states: [UIControl.State], cacheKey: String? = nil) {
        var imageResource: ImageResource?
        if let _url = url, let url = URL(string: _url) {
            imageResource = ImageResource(downloadURL: url, cacheKey: cacheKey)
        }
        states.forEach { state in
            component.kf.setImage(with: imageResource, for: state, placeholder: placeholder, options: options,
                                  completionHandler: { result in
                                      switch result {
                                          case let .success(value):
                                              Log.print.info(
                                                  "Image retrieved from: " +
                                                      "\(value.originalSource.url?.absoluteString ?? "Unknown source")")
                                          case let .failure(error):
                                              Log.print.warning(error.localizedDescription)
                                      }
            })
        }
    }
}