//
//  Property.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 7/22/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

public struct Property {
    public let domain: String?
    public let name: String
    public let value: Any?
    public let hasPath: Bool

    public init(name: String, hasPath: Bool, value: Any?, domain: String? = nil) {
        self.name = name
        self.hasPath = hasPath
        self.value = value
        self.domain = domain
    }
}
