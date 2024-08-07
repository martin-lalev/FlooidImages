//
//  StaticImageResource.swift
//  DandaniaResources
//
//  Created by Martin Lalev on 23.04.20.
//  Copyright © 2020 Martin Lalev. All rights reserved.
//

import Foundation

public final class StaticImageResource: ImageResource {
    
    public let id: String
    private let image: ImageConvertible?
    
    public init(id: String, for image: ImageConvertible?) {
        self.id = id
        self.image = image
    }
    
    public func load() async -> ImageConvertible? {
        self.image
    }
    
}
