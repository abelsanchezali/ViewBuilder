//
//  Numeric.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 10/21/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation
import CoreGraphics

// MARK: IntMaxConvertible Protocol

protocol IntMaxConvertible {
    func toIntMax() -> IntMax
}

// MARK: IntMaxConvertible for Integer Types

extension Int: IntMaxConvertible {
}

extension UInt: IntMaxConvertible {
}

extension Int8: IntMaxConvertible {
}

extension Int16: IntMaxConvertible {
}

extension Int32: IntMaxConvertible {
}

extension Int64: IntMaxConvertible {
}

extension UInt8: IntMaxConvertible {
}

extension UInt16: IntMaxConvertible {
}

extension UInt32: IntMaxConvertible {
}

extension UInt64: IntMaxConvertible {
}

// MARK: Int

extension Int {
    public init?(value: Any) {
        switch value {
        case let v as IntMaxConvertible:
            self = Int(v.toIntMax())
            break
        case let str as String:
            guard let v = Int(str) else {
                return nil
            }
            self = v
            break
        default:
            return nil
        }
    }
}

// MARK: DoubleMax Convertible Protocol

public typealias DoubleMax = Double

protocol DoubleMaxConvertible {
    func toDoubleMax() -> Double
}

extension Double: DoubleMaxConvertible {
    func toDoubleMax() -> Double {
        return self
    }
}

extension Float: DoubleMaxConvertible {
    func toDoubleMax() -> Double {
        return Double(self)
    }
}

extension CGFloat: DoubleMaxConvertible {
    func toDoubleMax() -> Double {
        return Double(self)
    }
}

// MARK: Double

extension Double {
    public init?(value: Any) {
        switch value {
        case let v as Double:
            self = v
            break
        case let v as IntMaxConvertible:
            self = Double(v.toIntMax())
            break
        case let v as DoubleMaxConvertible:
            self = v.toDoubleMax()
            break
        case let str as String:
            guard let v = Double(str) else {
                return nil
            }
            self = v
            break
        default:
            return nil
        }
    }
}
