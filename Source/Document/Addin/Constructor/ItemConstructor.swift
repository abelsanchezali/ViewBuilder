//
//  ItemConstructor.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 6/24/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

open class ItemConstructor: ObjectConstructor {
    private static let NameParameter = "name"
    private static let ValueParameter = "value"
    private static let Parameters = [ItemConstructor.NameParameter, ItemConstructor.ValueParameter]

    open func parametersKeys() -> [String] {
        return ItemConstructor.Parameters
    }

    open func createObject(with parameters: [String: Any], objectType: AnyClass, builder: DocumentBuilder) -> Any? {
        guard let type = objectType as? Item.Type else {
            return nil
        }
        guard let name = parameters[ItemConstructor.NameParameter] as? String else {
            Log.shared.write("Warning: Missing name for item.")
            return nil
        }
        if let value = parameters[ItemConstructor.ValueParameter] {
            return type.init(name: name, value: value)
        }
        return type.init(name: name, value: nil)
    }
}

extension Item: ObjectConstructorProvider {
    private static let objectConstructor = ItemConstructor()

    public dynamic class func resolveObjectConstructor() -> ObjectConstructor {
        return Item.objectConstructor
    }
}


