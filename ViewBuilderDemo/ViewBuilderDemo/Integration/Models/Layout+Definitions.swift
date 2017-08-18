//
//  Layout+Definitions.swift
//  ViewBuilderDemo
//
//  Created by Abel Sanchez on 7/2/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import ViewBuilder
import UIKit

public struct LayoutAnchor : OptionSet {
    public let rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    public static let none         = LayoutAnchor(rawValue: 0)

    public static let top          = LayoutAnchor(rawValue: 1 << 0)
    public static let left         = LayoutAnchor(rawValue: 1 << 1)
    public static let bottom       = LayoutAnchor(rawValue: 1 << 2)
    public static let right        = LayoutAnchor(rawValue: 1 << 3)
    public static let fill         = LayoutAnchor(rawValue: 1 << 4 - 1)

    public static let centerX      = LayoutAnchor(rawValue: 1 << 4)
    public static let centerY      = LayoutAnchor(rawValue: 1 << 5)
    public static let center       = LayoutAnchor(rawValue: (1 << 4) + (1 << 5))
}

extension LayoutAnchor: NSValueConvertible {
    public func convertToNSValue() -> NSValue? {
        return NSNumber(value: self.rawValue as Int)
    }
}

public class Anchor: Object, TextDeserializer {
    private static let AnchorByText: [String: LayoutAnchor] = ["Fill": LayoutAnchor.fill,
                                                               "None": LayoutAnchor.none,
                                                               "Left": LayoutAnchor.left,
                                                               "Top": LayoutAnchor.top,
                                                               "Right": LayoutAnchor.right,
                                                               "Bottom": LayoutAnchor.bottom,
                                                               "CenterX": LayoutAnchor.centerX,
                                                               "CenterY": LayoutAnchor.centerY,
                                                               "Center": LayoutAnchor.center]


    public static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        guard let text = text else {
            return nil
        }
        guard let words = service.parseValidWordsArray(from: text) else {
            return nil
        }
        var value = LayoutAnchor.none
        for word in words {
            guard let anchor = Anchor.AnchorByText[word] else {
                Log.shared.write("Warning: Ingnoring \"\(word)\" when processing LayoutAnchor deserialization.")
                continue
            }
            value.insert(anchor)
        }
        return value
    }
}
