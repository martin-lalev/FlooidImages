//
//  CachedImageResource.swift
//  DandaniaResources
//
//  Created by Martin Lalev on 21.07.20.
//  Copyright © 2020 Martin Lalev. All rights reserved.
//

import Foundation

public protocol ImageCacheContainer: Sendable {
    func fetch(for key: String, retriever: @Sendable @escaping () async -> ImageConvertible?) async -> ImageConvertible?
}

final class CachedImageResource: ImageResource {
    
    private let cacheService: ImageCacheContainer
    private let baseImage: ImageResource
    
    init(in cacheService: ImageCacheContainer, baseImageResource: ImageResource) {
        self.baseImage = baseImageResource
        self.cacheService = cacheService
    }
    
    var id: String {
        return self.baseImage.id
    }
    
    
    func load() async -> ImageConvertible? {
        await self.cacheService.fetch(for: self.id, retriever: {
            await self.baseImage.load()
        })
    }
    
}
extension ImageResource {
    public func cached(in cacheService: ImageCacheContainer?) -> ImageResource {
        return cacheService.map { CachedImageResource(in: $0, baseImageResource: self) } ?? self
    }
}
