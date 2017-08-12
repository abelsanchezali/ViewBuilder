//
//  ObjectStyle.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 7/5/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

open class ObjectStyle: DefaultConstructor {
    public required init() {
        
    }

    private var setters = [Setter]()

    open func add(setter: Setter) {
        setters.append(setter)
    }

    open func apply(to instance: KeyValueAccesible) {
        for setter in setters {
            PropertyHelper.setProperty(instance, name: setter.property, value: setter.value, hasPath: setter.hasPath)
        }
    }

    open func apply(to instance: NSObject) {
        for setter in setters {
            PropertyHelper.setProperty(instance, name: setter.property, value: setter.value, hasPath: setter.hasPath)
        }
    }

}

// MARK: - AttachableProperty

extension ObjectStyle: AttachableProperty {
    public func performAttachment(to instance: Any, name: String) -> Bool {
        if name != "style" {
            return false
        }
        guard let accesible = instance as? KeyValueAccesible else {
            Log.shared.write("Warning: Style properties only supported in KeyValueAccesible objects")
            return false
        }
        apply(to: accesible)
        return true
    }
}
