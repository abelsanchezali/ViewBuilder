//
//  FillRule.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 10/1/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

open class FillRule: Object, TextDeserializer {
    private static let StringToFillRule: [String: String] = ["non-zero": "non-zero",
                                                             "even-odd": "even-odd",
                                                             "NonZero": "non-zero",
                                                             "EvenOdd": "even-odd"]

    open static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        guard let text = text, let stringValue = service.parseValue(from: text) as? String else {
            Log.shared.write("Warning: Expected String value in FillRule.")
            return nil
        }
        let trimedValue = stringValue.trimmingCharacters(in: CharacterSet.whitespaces)
        guard let fillRule = FillRule.StringToFillRule[trimedValue] else {
            Log.shared.write("Warning: Invalid FillRule value \"\(trimedValue)\"")
            return nil
        }
        return fillRule
    }
}
