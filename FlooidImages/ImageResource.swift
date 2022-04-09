//
//  ImageView.swift
//  DandaniaUI
//
//  Created by Martin Lalev on 7.09.19.
//  Copyright © 2019 Martin Lalev. All rights reserved.
//

import Foundation

public typealias ImageConvertible = Data

public protocol ImageResource {
    var id: String { get }
    func load() async -> ImageConvertible?
}
