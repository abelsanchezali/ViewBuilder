//
//  UILabel.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 7/12/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

// MARK: - NSTextAlignment

extension NSTextAlignment: NSValueConvertible {
    public func convertToNSValue() -> NSValue? {
        return NSNumber(value: self.rawValue as Int)
    }
}

open class TextAlignment: Object, TextDeserializer {

    private static let TextAlignmentByText: [String: NSTextAlignment] = ["Center": NSTextAlignment.center,
                                                                         "Justified": NSTextAlignment.justified,
                                                                         "Left": NSTextAlignment.left,
                                                                         "Natural": NSTextAlignment.natural,
                                                                         "Right": NSTextAlignment.right]

    open static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        guard let value = text else {
            return nil
        }
        return TextAlignment.TextAlignmentByText[value]
    }
}

