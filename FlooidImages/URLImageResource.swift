//
//  URLImageResource.swift
//  FlooidImages
//
//  Created by Martin Lalev on 24/07/2022.
//

import Foundation

public class URLImageResource: ImageResource {
    
    public let id: String
    private let url: URL?
    
    public init(with id: String, for url: URL?) {
        self.id = id
        self.url = url
    }
    
    public func load() async -> ImageConvertible? {
        guard let url = url else { return nil }
        var cancellable: URLSessionDataTask?
        let onCancel = { cancellable?.cancel() }
        return await withTaskCancellationHandler(
            handler: { onCancel() },
            operation: {
                await withCheckedContinuation { (continuation: CheckedContinuation<Data?, Never>) in
                    
                    let task = URLSession.shared.dataTask(with: url) { (imageData, _, _) in
                        guard !Task.isCancelled else { return }
                        continuation.resume(returning: imageData)
                    }
                    task.resume()

                    cancellable = task
                }
            }
        )
    }
}
