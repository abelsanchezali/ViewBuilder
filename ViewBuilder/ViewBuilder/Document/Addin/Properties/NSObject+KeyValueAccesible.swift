//
//  NSObject+KeyValueAccesible.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 7/29/17.
//  Copyright © 2017 Abel Sanchez. All rights reserved.
//

import UIKit

extension NSObject: KeyValueAccesible {
    @nonobjc public func resolveValue(forKey key: String) -> Any? {
        return ReflectionHelper.getPropertyWithName(key, instance: self)
    }
    @nonobjc public func replaceValue(_ value: Any?, forKey key: String) -> Bool {
        return ReflectionHelper.setPropertyWithName(key, value: value, instance: self)
    }

    @nonobjc public func resolveValue(forKeyPath keyPath: String) -> Any? {
        return ReflectionHelper.getPropertyWithPath(keyPath, instance: self)
    }

    @nonobjc public func replaceValue(_ value: Any?, forKeyPath keyPath: String) -> Bool {
        return ReflectionHelper.setPropertyWithPath(keyPath, value: value, instance: self)
    }
}
