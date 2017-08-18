//
//  NSValueConvertible.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 6/18/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

public protocol NSValueConvertible {
    func convertToNSValue() -> NSValue?
}