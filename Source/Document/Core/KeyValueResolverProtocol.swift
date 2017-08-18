//
//  KeyValueResolverProtocol.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 7/7/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

public protocol KeyValueResolverProtocol: class {
    func resolveValue(for key: String) -> Any?
}
