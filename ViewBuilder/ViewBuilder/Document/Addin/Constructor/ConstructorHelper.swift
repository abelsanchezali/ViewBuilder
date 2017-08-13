//
//  ConstructorHelper.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 11/7/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

class ConstructorHelper {
    private static let defaultConstructor = DefaultObjectConstructor()

    static func getConstructorForType(_ objectType: AnyClass) -> ObjectConstructor? {
        guard let constructorProvider = objectType as? ObjectConstructorProvider.Type else {
            return ConstructorHelper.defaultConstructor
        }
        return constructorProvider.resolveObjectConstructor()
    }
}
