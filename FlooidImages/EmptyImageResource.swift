//
//  EmptyImageResource.swift
//  DandaniaResources
//
//  Created by Martin Lalev on 23.04.20.
//  Copyright © 2020 Martin Lalev. All rights reserved.
//

import Foundation

public class EmptyImageResource: ImageResource {
    
    public let id: String = "<NULL>"
    
    public init() {}
    
    public func load(_ callback: @escaping (ImageConvertible?) -> Void) -> ImageLoaderCancellable? {
        callback(nil)
        return nil
    }
    
}
