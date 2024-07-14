//
//  URLImageResource.swift
//  FlooidImages
//
//  Created by Martin Lalev on 24/07/2022.
//

import Foundation

public final class URLImageResource: ImageResource {
    public let id: String
    private let url: URL?
    
    public init(with id: String, for url: URL?) {
        self.id = id
        self.url = url
    }
    
    public func load() async -> ImageConvertible? {
        guard let url = url else { return nil }
        
        do {
            let (imageData, _) = try await URLSession.shared.data(from: url)
            return imageData
        } catch {
            return nil
        }
    }
}
