//
//  Item.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 6/23/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

open class Item: NSObject {
    public let name: String
    open var value: Any?

    public required init(name: String, value: Any?) {
        self.name = name
        self.value = value
    }
}

extension Item: ValueProviderProtocol {
    public func getPresentedValue() -> Any? {
        return value
    }
}
