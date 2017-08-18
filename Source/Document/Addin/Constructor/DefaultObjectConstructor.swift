//
//  DefaultObjectConstructor.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 6/13/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

open class DefaultObjectConstructor: ObjectConstructor {
    private static let Parameters = [String]()

    open func parametersKeys() -> [String] {
        return DefaultObjectConstructor.Parameters
    }
    
    open func createObject(with parameters: [String: Any], objectType: AnyClass, builder: DocumentBuilder) -> Any? {
        if let nsObjectType = objectType as? NSObject.Type {
            return nsObjectType.init()
        }
        if let swiftObjectType = objectType as? DefaultConstructor.Type {
            return swiftObjectType.init()
        }
        return nil
    }
}
