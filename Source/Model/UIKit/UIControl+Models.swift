//
//  UIControlModel.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 6/16/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

// MARK: - UIEdgeInsets

extension UIControl.State: NSValueConvertible {
    public func convertToNSValue() -> NSValue? {
        return NSNumber(value: self.rawValue as UInt)
    }
}

open class ControlState: Object, TextDeserializer {
  private static let ControlStateByText: [String: UIControl.State] = {
    var values = ["Normal": UIControl.State.normal,
                  "Highlighted": UIControl.State.highlighted,
                  "Disabled": UIControl.State.disabled,
                  "Selected": UIControl.State.selected,
                  "Application": UIControl.State.application,
                  "Reserved": UIControl.State.reserved]
        if #available(iOS 9.0, *) {
          values["Focused"] = UIControl.State.focused
        }
        return values
    }()

    public static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        guard let value = text, value.count > 0 else {
            return nil
        }
        guard let controlState = ControlState.ControlStateByText[value] else {
            return nil
        }
        return controlState
    }
}
