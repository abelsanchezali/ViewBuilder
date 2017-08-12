//
//  BuildOptions.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 6/18/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

open class BuildOptions: NSObject {
    open var verbose = true

    open var document = DocumentOptions()
    open var instantiation = InstantiationOptions()
    open var factory = FactoryOptions()
}
