//
//  ObjectConstructorProvider.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 11/6/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

@objc public protocol ObjectConstructorProvider {
    static func resolveObjectConstructor() -> ObjectConstructor
}
