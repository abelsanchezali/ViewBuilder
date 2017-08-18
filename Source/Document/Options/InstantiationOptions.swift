//
//  InstantiationOptions.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 6/18/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

open class InstantiationOptions: NSObject {

    open var verbose = true

    open let baseInstance: Any?

    public init(instance: Any?) {
        baseInstance = instance
    }

    public override init() {
        baseInstance = nil
    }

}
