//
//  ResourcesConstructor.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 6/25/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

open class ResourcesConstructor: ObjectConstructor {
    private static let PathParameter = "path"
    private static let Parameters = [ResourcesConstructor.PathParameter]

    open func parametersKeys() -> [String] {
        return ResourcesConstructor.Parameters
    }

    open func createObject(with parameters: [String: Any], objectType: AnyClass, builder: DocumentBuilder) -> Any? {
        guard let type = objectType as? Resources.Type else {
            return nil
        }
        if let path = parameters[ResourcesConstructor.PathParameter] as? String {
            return type.init(path: path)
        }
        return type.init()
    }
}

extension Resources: ObjectConstructorProvider {
    private static let objectConstructor = ResourcesConstructor()

    public dynamic class func resolveObjectConstructor() -> ObjectConstructor {
        return Resources.objectConstructor
    }
}
