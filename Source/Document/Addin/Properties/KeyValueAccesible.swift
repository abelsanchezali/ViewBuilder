//
//  KeyValueAccesible.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 10/20/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

public protocol KeyValueAccesible {
    func resolveValue(forKey key: String) -> Any?
    func replaceValue(_ value: Any?, forKey key: String) -> Bool
    func resolveValue(forKeyPath keyPath: String) -> Any?
    func replaceValue(_ value: Any?, forKeyPath keyPath: String) -> Bool
}
