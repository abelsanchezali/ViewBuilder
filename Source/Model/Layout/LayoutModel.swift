//
//  LayoutModel.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 7/4/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

// MARK: - LayoutOrientation

extension LayoutOrientation: NSValueConvertible {
    public func convertToNSValue() -> NSValue? {
        return NSNumber(value: self.rawValue as Int)
    }
}


open class Orientation: Object, TextDeserializer {
    private static let OrientationByText: [String: LayoutOrientation] = ["Horizontal": LayoutOrientation.horizontal,
                                                                          "Vertical": LayoutOrientation.vertical]

    open static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        guard let value = text else {
            return nil
        }
        return Orientation.OrientationByText[value]
    }
}

// MARK: - LayoutAlignment

extension LayoutAlignment: NSValueConvertible {
    public func convertToNSValue() -> NSValue? {
        return NSNumber(value: self.rawValue as Int)
    }
}

open class Alignment: Object, TextDeserializer {
    private static let AlignmentByText: [String: LayoutAlignment] = ["Center": LayoutAlignment.center,
                                                                     "Maximum": LayoutAlignment.maximum,
                                                                     "Minimum": LayoutAlignment.minimum,
                                                                     "Stretch": LayoutAlignment.stretch]

    open static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        guard let value = text else {
            return nil
        }
        return Alignment.AlignmentByText[value.trimmingCharacters(in: CharacterSet.whitespaces)]
    }
}
