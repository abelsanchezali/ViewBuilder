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
    func toIntMax() -> Int64
}

// MARK: IntMaxConvertible for Integer Types

extension Int: IntMaxConvertible {
  func toIntMax() -> Int64 {
      return Int64(self)
  }
}

extension UInt: IntMaxConvertible {
  func toIntMax() -> Int64 {
      return Int64(self)
  }
}

extension Int8: IntMaxConvertible {
  func toIntMax() -> Int64 {
      return Int64(self)
  }
}

extension Int16: IntMaxConvertible {
  func toIntMax() -> Int64 {
      return Int64(self)
  }
}

extension Int32: IntMaxConvertible {
  func toIntMax() -> Int64 {
      return Int64(self)
  }
}

extension Int64: IntMaxConvertible {
  func toIntMax() -> Int64 {
      return Int64(self)
  }
}

extension UInt8: IntMaxConvertible {
  func toIntMax() -> Int64 {
      return Int64(self)
  }
}

extension UInt16: IntMaxConvertible {
  func toIntMax() -> Int64 {
      return Int64(self)
  }
}

extension UInt32: IntMaxConvertible {
  func toIntMax() -> Int64 {
      return Int64(self)
  }
}

extension UInt64: IntMaxConvertible {
  func toIntMax() -> Int64 {
      return Int64(self)
  }
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
