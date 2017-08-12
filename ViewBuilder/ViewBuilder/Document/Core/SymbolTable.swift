//
//  SymbolTable.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 7/9/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

class SymbolTable {
    var table = [String: Any]()

    public subscript(name: String) -> Any? {
        get {
            return table[name]
        }
        set {
            if let value = newValue {
                table[name] = value
            } else {
                table.removeValue(forKey: name)
            }
        }
    }
}
