//
//  AttachableProperty.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 7/4/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

public protocol AttachableProperty {
    func performAttachment(to instance: Any, name: String) -> Bool
}
