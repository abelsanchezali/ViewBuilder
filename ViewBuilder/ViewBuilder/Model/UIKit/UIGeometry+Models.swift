//
//  UIGeometryModel.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 6/15/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

// MARK: - UIEdgeInsets

extension UIEdgeInsets {
    public var totalWidth: CGFloat {
        return left + right
    }

    public var totalHeight: CGFloat {
        return top + bottom
    }
}

extension UIEdgeInsets: NSValueConvertible {
    public func convertToNSValue() -> NSValue? {
        return NSValue(uiEdgeInsets: self)
    }
}

open class EdgeInsets: Object, TextDeserializer {
    open static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        guard let value = text, value.characters.count > 0 else {
            return UIEdgeInsets.zero
        }
        guard let array = service.parseValidDoubleArray(from: value)else {
            return nil
        }
        switch array.count {
        case 1:
            return UIEdgeInsetsMake(CGFloat(array[0]), CGFloat(array[0]), CGFloat(array[0]), CGFloat(array[0]))
        case 2:
            return UIEdgeInsetsMake(CGFloat(array[0]), CGFloat(array[1]), CGFloat(array[0]), CGFloat(array[1]))
        case 4:
            return UIEdgeInsetsMake(CGFloat(array[0]), CGFloat(array[1]), CGFloat(array[2]), CGFloat(array[3]))
        default:
            return nil
        }
    }
}
