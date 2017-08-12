//
//  MathHelper.swift
//  ViewBuilderDemo
//
//  Created by Abel Sanchez on 9/16/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

public class MathHelper {
    public class func random() -> Int {
        return Int(arc4random() % UInt32(Int32.max))
    }
}
