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
    private let onLoad: (ImageConvertible?, @escaping () -> Void) -> Void
    
    init(for baseImageResource: ImageResource, _ onLoad: @escaping (ImageConvertible?, @escaping () -> Void) -> Void) {
        self.baseImage = baseImageResource
        self.onLoad = onLoad
    }
    
    var id: String {
        return self.baseImage.id
    }
    
    
    func load(_ callback: @escaping (ImageConvertible?) -> Void) -> ImageLoaderCancellable? {
        return ImageCancellable().loadImageResource(self.baseImage) { cancellable, image in
            self.onLoad(image) {
                callback(image)
            }
        }
    }
    
}
extension ImageResource {
    public func onLoad(_ onLoad: @escaping (ImageConvertible?, @escaping () -> Void) -> Void) -> ImageResource {
        return ImageResourceLoadProxy(for: self, onLoad)
    }
    public func onLoad(_ onLoad: @escaping (ImageConvertible?) -> Void) -> ImageResource {
        return ImageResourceLoadProxy(for: self) {
            onLoad($0)
            $1()
        }
    }
}
