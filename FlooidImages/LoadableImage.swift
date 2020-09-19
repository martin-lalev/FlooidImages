//
//  LoadableImage.swift
//  DandaniaResources
//
//  Created by Martin Lalev on 26.07.20.
//  Copyright © 2020 Martin Lalev. All rights reserved.
//

import Foundation

public class LoadableImage {
    
    let base: ImageBase
    let modifiers: [ImageModifier]
    let cache: ImageCacheContainer?
    let onLoad: (ImageConvertible?) -> Void

    public init(for base: ImageBase, modifiers: [ImageModifier] = [], cache: ImageCacheContainer? = nil, onLoad: @escaping (ImageConvertible?) -> Void = { _ in }) {
        self.base = base
        self.modifiers = modifiers
        self.cache = cache
        self.onLoad = onLoad
    }
    
}

public extension LoadableImage {
    func modify(_ modifier: ImageModifier) -> LoadableImage {
        LoadableImage(
            for: self.base,
            modifiers: self.modifiers + [modifier],
            cache: self.cache,
            onLoad: self.onLoad
        )
    }
}

extension LoadableImage: ImageResource {
    
    private var resource: ImageResource {
        self.base
            .onLoad(self.onLoad)
            .with(self.modifiers)
            .cached(in: self.cache)
    }
    
    public var id: String {
        return self.resource.id
    }
    public func load(_ callback: @escaping (ImageConvertible?) -> Void) -> ImageLoaderCancellable? {
        return self.resource.load(callback)
    }
    
}

public extension ImageBase {
    func loadable(with cacheService: ImageCacheContainer? = nil, onLoad: @escaping (ImageConvertible?) -> Void = { _ in }) -> LoadableImage {
        return LoadableImage(for: self, cache: cacheService, onLoad: onLoad)
    }
}
