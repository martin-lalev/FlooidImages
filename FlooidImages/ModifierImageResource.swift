//
//  ModifierImageResource.swift
//  DandaniaResources
//
//  Created by Martin Lalev on 26.07.20.
//  Copyright © 2020 Martin Lalev. All rights reserved.
//

import Foundation

public protocol ImageModifier {
    var id: String { get }
    func modify(_ original: ImageConvertible?) -> ImageConvertible?
}

class ModifierImageResource: ImageResource {
    
    private let baseImage: ImageResource
    private let modifiers: [ImageModifier]
    
    init(for baseImageResource: ImageResource, with modifiers: [ImageModifier]) {
        self.baseImage = baseImageResource
        self.modifiers = modifiers
    }
    
    var id: String {
        return "\(self.baseImage.id).\(self.modifiers.map({ $0.id }).joined(separator: "."))"
    }
    
    
    func load() async -> ImageConvertible? {
        let image = await self.baseImage.load()
        return await withCheckedContinuation { continuation in
            DispatchQueue(label: "ImageEffects", qos: .default).async {
                let result = self.modifiers.reduce(image) { $1.modify($0) }
                continuation.resume(returning: result)
            }
        }
    }
    
}

extension ImageResource {
    public func with(_ modifiers: [ImageModifier]) -> ImageResource {
        return ModifierImageResource(for: self, with: modifiers)
    }
}
