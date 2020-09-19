//
//  FallbackImageResource.swift
//  DandaniaResources
//
//  Created by Martin Lalev on 23.04.20.
//  Copyright © 2020 Martin Lalev. All rights reserved.
//

import Foundation

class FallbackImageResource: ImageResource {
    
    private let baseImage: ImageResource
    private let fallbackImage: ImageResource
    
    init(for baseImageResource: ImageResource, with fallbackImageResource: ImageResource) {
        self.baseImage = baseImageResource
        self.fallbackImage = fallbackImageResource
    }
    
    var id: String {
        return "\(self.baseImage.id)_fallback_\(self.fallbackImage.id)"
    }
    
    
    func load(_ callback: @escaping (ImageConvertible?) -> Void) -> ImageLoaderCancellable? {
        return ImageCancellable().loadImageResource(self.baseImage) { cancellable, image in
            if let image = image {
                callback(image)
            } else {
                cancellable.loadImageResource(self.fallbackImage) {
                    callback($1)
                }
            }
        }
    }
    
}
extension ImageResource {
    public func fallback(to imageResource: ImageResource) -> ImageResource {
        return FallbackImageResource(for: self, with: imageResource)
    }
    public func fallback(to imageResource: ImageResource?) -> ImageResource {
        return imageResource.map { self.fallback(to: $0) } ?? self
    }
}
