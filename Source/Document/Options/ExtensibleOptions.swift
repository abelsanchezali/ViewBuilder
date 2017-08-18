//
//  ExtensibleOptions.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 6/18/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

open class ExtensibleOptions: NSObject {

    private var extendedData = [String: Any]()

    open subscript(key: String) -> Any? {
        get {
            return extendedData[key]
        }
        set(newValue) {
            extendedData[key] = newValue
        }
    }
}

