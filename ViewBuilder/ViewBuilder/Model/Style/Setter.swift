//
//  Setter.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 7/5/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

open class Setter: NSObject {
    open let property: String
    open let hasPath: Bool
    open var value: Any?

    public required init(property: String) {
        self.property = property
        self.hasPath = property.contains(".")
    }
    
}
