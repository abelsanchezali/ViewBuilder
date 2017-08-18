//
//  HashHelper.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 7/11/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

public class HashHelper {

    // DJB Hash Function
    public static func computeHash<T: Hashable>(_ array: [T]) -> Int {
        return array.reduce(5381) {
            ($0 << 5) &+ $0 &+ $1.hashValue
        }
    }

}
