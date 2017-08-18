//
//  AttachableObject.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 7/4/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

open class AttachableObject: NSObject {
    open func add(item: Any) -> Bool {
        return false
    }

    open func canBeAttached(to instance: Any) -> Bool {
        return false
    }

    open func performAttachment(to instance: Any) {

    }
}
