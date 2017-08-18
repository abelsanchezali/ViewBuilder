//
//  ValueProviderProtocol.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 7/28/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

public protocol ValueProviderProtocol {
    func getPresentedValue() -> Any?
}