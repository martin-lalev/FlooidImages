//
//  ImageBase.swift
//  DandaniaResources
//
//  Created by Martin Lalev on 26.07.20.
//  Copyright © 2020 Martin Lalev. All rights reserved.
//

import Foundation

public class ImageBase {
    
    let image: ImageResource
    let cache: ImageCacheContainer?
    var fallback: ImageBase?
    
    public init(image: ImageResource, cache: ImageCacheContainer? = nil, fallback: ImageBase? = nil) {
        self.image = image
        self.cache = cache
        self.fallback = fallback
    }
    
}

extension ImageBase: ImageResource {
    
    private var resource: ImageResource {
        self.image
            .cached(in: self.cache)
            .fallback(to: self.fallback)
    }
    
    public var id: String {
        return self.resource.id
    }
    public func load(_ callback: @escaping (ImageConvertible?) -> Void) -> ImageLoaderCancellable? {
        return self.resource.load(callback)
    }

}

public extension ImageResource {
    func asImageBase(cache: ImageCacheContainer? = nil, fallback: ImageBase? = nil) -> ImageBase {
        return ImageBase(image: self, cache: cache, fallback: fallback)
    }
}
