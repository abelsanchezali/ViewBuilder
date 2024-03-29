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
    public static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        guard let value = text, value.count > 0 else {
            return UIEdgeInsets.zero
        }
        guard let array = service.parseValidDoubleArray(from: value)else {
            return nil
        }
        switch array.count {
        case 1:
          return UIEdgeInsets(top:CGFloat(array[0]), left:CGFloat(array[0]), bottom:CGFloat(array[0]), right:CGFloat(array[0]))
        case 2:
          return UIEdgeInsets(top:CGFloat(array[0]), left:CGFloat(array[1]), bottom:CGFloat(array[0]), right:CGFloat(array[1]))
        case 4:
          return UIEdgeInsets(top:CGFloat(array[0]), left:CGFloat(array[1]), bottom:CGFloat(array[2]), right:CGFloat(array[3]))
        default:
            return nil
        }
    }
}
