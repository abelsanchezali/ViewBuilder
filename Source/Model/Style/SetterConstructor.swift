//
//  SetterConstructor.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 7/5/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

open class SetterConstructor: ObjectConstructor {
    private static let PropertyParameter = "property"
    private static let ValueParameter = "value"
    private static let Parameters = [SetterConstructor.PropertyParameter, SetterConstructor.ValueParameter]

    open func parametersKeys() -> [String] {
        return SetterConstructor.Parameters
    }

    open func createObject(with parameters: [String: Any], objectType: AnyClass, builder: DocumentBuilder) -> Any? {
        guard let type = objectType as? Setter.Type else {
            return nil
        }
        guard let property = parameters[SetterConstructor.PropertyParameter] as? String else {
            Log.shared.write("Warning: Missing property for setter.")
            return nil
        }
        let instance = type.init(property: property)
        if let value = parameters[SetterConstructor.ValueParameter] {
            instance.value = value
        }
        return instance
    }
}

extension Setter: ObjectConstructorProvider {
    private static let objectConstructor = SetterConstructor()

    public dynamic class func resolveObjectConstructor() -> ObjectConstructor {
        return Setter.objectConstructor
    }
}
