//
//  CGGeometryModel.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 6/15/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import CoreGraphics
import Foundation

// MARK: - CGRect

extension CGRect: NSValueConvertible {
    public func convertToNSValue() -> NSValue? {
        return NSValue(cgRect: self)
    }
}

open class Rect: Object, TextDeserializer {
    open static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        guard let value = text, value.characters.count > 0 else {
            return NSValue(cgRect: CGRect.zero)
        }
        guard let array = service.parseValidDoubleArray(from: value), array.count == 4 else {
            return nil
        }
        return CGRect(x: CGFloat(array[0]), y: CGFloat(array[1]), width: CGFloat(array[2]), height: CGFloat(array[3]))
    }
}

extension CGRect: TextDeserializer {
    public static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        return Rect.deserialize(text: text, service: service)
    }
}

// MARK: - CGPoint

extension CGPoint: NSValueConvertible {
    public func convertToNSValue() -> NSValue? {
        return NSValue(cgPoint: self)
    }
}

open class Point: Object, TextDeserializer {
    open static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        guard let value = text, value.characters.count > 0 else {
            return NSValue(cgRect: CGRect.zero)
        }
        guard let array = service.parseValidDoubleArray(from: value), array.count == 2 else {
            return nil
        }
        return CGPoint(x: CGFloat(array[0]), y: CGFloat(array[1]))
    }
}

extension CGPoint: TextDeserializer {
    public static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        return Point.deserialize(text: text, service: service)
    }
}

// MARK: - CGSize

extension CGSize: NSValueConvertible {
    public func convertToNSValue() -> NSValue? {
        return NSValue(cgSize: self)
    }
}


open class Size: Object, TextDeserializer {
    open static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        guard let value = text, value.characters.count > 0 else {
            return NSValue(cgRect: CGRect.zero)
        }
        guard let array = service.parseValidDoubleArray(from: value), array.count == 2 else {
            return nil
        }
        return CGSize(width: CGFloat(array[0]), height: CGFloat(array[1]))
    }
}

// MARK: - CGVector

extension CGVector: NSValueConvertible {
    public func convertToNSValue() -> NSValue? {
        return NSValue(cgVector: self)
    }
}

open class Vector: Object, TextDeserializer {
    open static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        guard let value = text, value.characters.count > 0 else {
            return NSValue(cgRect: CGRect.zero)
        }
        guard let array = service.parseValidDoubleArray(from: value), array.count == 2 else {
            return nil
        }
        return CGVector(dx: CGFloat(array[0]), dy: CGFloat(array[1]))
    }
}

