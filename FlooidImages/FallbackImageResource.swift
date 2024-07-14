//
//  FallbackImageResource.swift
//  DandaniaResources
//
//  Created by Martin Lalev on 23.04.20.
//  Copyright © 2020 Martin Lalev. All rights reserved.
//

import Foundation

final class FallbackImageResource: ImageResource {
    
    private let baseImage: ImageResource
    private let fallbackImage: ImageResource
    
    init(for baseImageResource: ImageResource, with fallbackImageResource: ImageResource) {
        self.baseImage = baseImageResource
        self.fallbackImage = fallbackImageResource
    }
    
    var id: String {
        return "\(self.baseImage.id)_fallback_\(self.fallbackImage.id)"
    }
    
    
    func load() async -> ImageConvertible? {
        let image = await self.baseImage.load()
        if let image = image, !image.isEmpty {
            return image
        } else {
            return await self.fallbackImage.load()
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
