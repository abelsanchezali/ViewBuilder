//
//  UIButton.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 6/14/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

open class StringForState: NSObject, TextDeserializer {
    open let value: String?
    open let state: UIControlState

    public init(value: String?, state: UIControlState = UIControlState()) {
        self.value = value
        self.state = state
    }

    open static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        guard let value = text else {
            return nil
        }
        if let values = service.parseKeyValueSequence(from: value, params: ["value", "state"]) {
            guard let state = values[1] as? UIControlState else {
                    return nil
            }
            return StringForState(value: String(describing: values[0]), state: state)
        }
        if let value = service.parseValue(from: value) {
            return StringForState(value: String(describing: value))
        }
        return StringForState(value: nil)
    }
}

open class AttributedForState: NSObject, TextDeserializer {
    open var value: NSAttributedString?
    open var state: UIControlState

    public init(value: NSAttributedString?, state: UIControlState = UIControlState()) {
        self.value = value
        self.state = state
    }

    open static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        guard let value = text else {
            return nil
        }
        if let values = service.parseKeyValueSequence(from: value, params: ["value", "state"]) {
            guard let attributed = values[0] as? NSAttributedString,
                      let state = values[1] as? UIControlState else {
                    return nil
            }
            return AttributedForState(value: attributed, state: state)
        }
        guard let attributed = service.parseValue(from: value) as? NSAttributedString else {
            return nil
        }
        return AttributedForState(value: attributed)
    }
}

open class ColorForState: NSObject, TextDeserializer {
    open var value: UIColor?
    open var state: UIControlState

    public init(value: UIColor?, state: UIControlState = UIControlState()) {
        self.value = value
        self.state = state
    }

    open static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        guard let value = text else {
            return nil
        }
        if let values = service.parseKeyValueSequence(from: value, params: ["value", "state"]) {
            guard let color = values[0] as? UIColor,
                      let state = values[1] as? UIControlState else {
                    return nil
            }
            return ColorForState(value: color, state: state)
        }
        guard let color = service.parseValue(from: value) as? UIColor else {
            return nil
        }
        return ColorForState(value: color)
    }
}

open class ImageForState: NSObject, TextDeserializer {
    open var value: UIImage?
    open var state: UIControlState

    public init(value: UIImage?, state: UIControlState = UIControlState()) {
        self.value = value
        self.state = state
    }

    open static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        guard let value = text else {
            return nil
        }
        if let values = service.parseKeyValueSequence(from: value, params: ["value", "state"]) {
            guard let image = values[0] as? UIImage,
                      let state = values[1] as? UIControlState else {
                    return nil
            }
            return ImageForState(value: image, state: state)
        }
        guard let image = service.parseValue(from: value) as? UIImage else {
            return nil
        }
        return ImageForState(value: image)
    }
}

// MARK: - UIButtonType

extension UIButtonType: NSValueConvertible {
    public func convertToNSValue() -> NSValue? {
        return NSNumber(value: self.rawValue as Int)
    }
}

open class ButtonType: Object, TextDeserializer {
    private static let ButtonTypeByText: [String: UIButtonType] = ["Custom": UIButtonType.custom,
                                                                   "System": UIButtonType.system,
                                                                   "DetailDisclosure": UIButtonType.detailDisclosure,
                                                                   "InfoLight": UIButtonType.infoLight,
                                                                   "InfoDark": UIButtonType.infoDark,
                                                                   "ContactAdd": UIButtonType.contactAdd,
                                                                   "RoundedRect": UIButtonType.roundedRect]

    open static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        guard let value = text else {
            return nil
        }
        return ButtonType.ButtonTypeByText[value]
    }
}
