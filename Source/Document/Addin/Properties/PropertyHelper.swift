//
//  PropertyHelper.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 10/21/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

class PropertyHelper {

    @discardableResult public static func setProperty(_ instance: Any, name: String, value: Any?, hasPath: Bool = false) -> Bool {
        if let accesible = instance as? KeyValueAccesible {
            return hasPath ?
                accesible.replaceValue(value, forKeyPath: name) :
                accesible.replaceValue(value, forKey: name)
        }
        return false
    }

    public static func getProperty(_ instance: Any, name: String, hasPath: Bool = false) -> Any? {
        if let accesible = instance as? KeyValueAccesible {
            return hasPath ?
                accesible.resolveValue(forKeyPath: name) :
                accesible.resolveValue(forKey: name)
        }
        return nil
    }
}
