//
//  UIControlModel.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 6/16/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

// MARK: - UIEdgeInsets

extension UIControlState: NSValueConvertible {
    public func convertToNSValue() -> NSValue? {
        return NSNumber(value: self.rawValue as UInt)
    }
}

open class ControlState: Object, TextDeserializer {
    private static let ControlStateByText: [String: UIControlState] = {
        var values = ["Normal": UIControlState.normal,
                      "Highlighted": UIControlState.highlighted,
                      "Disabled": UIControlState.disabled,
                      "Selected": UIControlState.selected,
                      "Application": UIControlState.application,
                      "Reserved": UIControlState.reserved]
        if #available(iOS 9.0, *) {
            values["Focused"] = UIControlState.focused
        }
        return values
    }()

    open static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        guard let value = text, value.characters.count > 0 else {
            return nil
        }
        guard let controlState = ControlState.ControlStateByText[value] else {
            return nil
        }
        return controlState
    }
}
