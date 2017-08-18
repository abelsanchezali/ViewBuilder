//
//  ObjectConstructor.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 6/11/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

@objc public protocol ObjectConstructor {
    func parametersKeys() -> [String]
    func createObject(with parameters: [String: Any], objectType: AnyClass, builder: DocumentBuilder) -> Any?
}
