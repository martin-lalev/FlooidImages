//
//  ImageResourceLoadProxy.swift
//  DandaniaResources
//
//  Created by Martin Lalev on 23.04.20.
//  Copyright © 2020 Martin Lalev. All rights reserved.
//

import Foundation

class ImageResourceLoadProxy: ImageResource {
    
    private let baseImage: ImageResource
    private let onLoad: (ImageConvertible?) async -> Void
    
    init(for baseImageResource: ImageResource, _ onLoad: @escaping (ImageConvertible?) async -> Void) {
        self.baseImage = baseImageResource
        self.onLoad = onLoad
    }
    
    var id: String {
        return self.baseImage.id
    }
    
    func load() async -> ImageConvertible? {
        let image = await self.baseImage.load()
        await self.onLoad(image)
        return image
    }
    
}
extension ImageResource {
    public func onLoad(_ onLoad: @escaping (ImageConvertible?) async -> Void) -> ImageResource {
        return ImageResourceLoadProxy(for: self, onLoad)
    }
    public func onLoad(_ onLoad: @escaping (ImageConvertible?) -> Void) -> ImageResource {
        return ImageResourceLoadProxy(for: self) {
            onLoad($0)
        }
    }
}
