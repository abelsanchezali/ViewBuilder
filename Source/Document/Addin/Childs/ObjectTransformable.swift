//
//  ObjectTransformable.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 6/28/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

public protocol ObjectTransformable: AnyObject {
    func transformToObjects() -> [Any]?
}
