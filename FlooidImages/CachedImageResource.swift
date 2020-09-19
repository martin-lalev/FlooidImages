//
//  CachedImageResource.swift
//  DandaniaResources
//
//  Created by Martin Lalev on 21.07.20.
//  Copyright © 2020 Martin Lalev. All rights reserved.
//

import Foundation

public protocol ImageCacheContainer {
    
    @discardableResult
    func set(_ value: ImageConvertible?, for key: String, completed: @escaping () -> Void) -> ImageLoaderCancellable?
    
    @discardableResult
    func get(for key: String, completed: @escaping (ImageConvertible?) -> Void) -> ImageLoaderCancellable?
    
    func has(for key: String) -> Bool

}

class CachedImageResource: ImageResource {
    
    private let cacheService: ImageCacheContainer
    private let baseImage: ImageResource
    
    init(in cacheService: ImageCacheContainer, baseImageResource: ImageResource) {
        self.baseImage = baseImageResource
        self.cacheService = cacheService
    }
    
    var id: String {
        return self.baseImage.id
    }
    
    
    func load(_ callback: @escaping (ImageConvertible?) -> Void) -> ImageLoaderCancellable? {
        if self.cacheService.has(for: self.id) {
            return self.cacheService.get(for: self.id, completed: callback)
        } else {
            return ImageCancellable().loadImageResource(self.baseImage) { (cancellable, result) in
                self.cacheService.set(result, for: self.id) {
                    callback(result)
                }
            }
        }
    }
    
}
extension ImageResource {
    public func cached(in cacheService: ImageCacheContainer?) -> ImageResource {
        return cacheService.map { CachedImageResource(in: $0, baseImageResource: self) } ?? self
    }
}
