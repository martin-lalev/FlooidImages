//
//  ImageView.swift
//  DandaniaUI
//
//  Created by Martin Lalev on 7.09.19.
//  Copyright © 2019 Martin Lalev. All rights reserved.
//

import Foundation

public typealias ImageConvertible = Data

public protocol ImageLoaderCancellable {
    func cancel()
}

public protocol ImageResource {
    var id: String { get }
    func load(_ callback: @escaping (ImageConvertible?) -> Void) -> ImageLoaderCancellable?
}



public class ImageCancellable: ImageLoaderCancellable {
    public private(set) var cancelled = false
    public var subCancellable: ImageLoaderCancellable?
    
    public init() {}
    
    public func cancel() {
        self.cancelled = true
        self.subCancellable?.cancel()
    }
    
    public func perform<T>(on queue: DispatchQueue, _ work: @escaping () -> T, _ callback: @escaping (T) -> Void) {
        queue.async {
            guard !self.cancelled else { return }
            let result = work()
            DispatchQueue.main.async {
                guard !self.cancelled else { return }
                callback(result)
            }
        }
    }
    
    @discardableResult
    public func loadImageResource(_ resource: ImageResource, _ callback: @escaping (ImageCancellable, ImageConvertible?) -> Void) -> ImageCancellable? {
        self.subCancellable = resource.load {
            guard !self.cancelled else { return }
            callback(self, $0)
        }
        return self.subCancellable.map { _ in self }
    }
    
}
