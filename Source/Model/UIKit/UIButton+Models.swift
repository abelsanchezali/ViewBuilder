//
//  UIButton.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 6/14/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

@objc open class StringForState: NSObject, TextDeserializer {
  @objc public let value: String?
  @objc public let state: UIControl.State

  public init(value: String?, state: UIControl.State = UIControl.State()) {
        self.value = value
        self.state = state
    }

    public static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        guard let value = text else {
            return nil
        }
        if let values = service.parseKeyValueSequence(from: value, params: ["value", "state"]) {
          guard let state = values[1] as? UIControl.State else {
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

@objc open class AttributedForState: NSObject, TextDeserializer {
    @objc open var value: NSAttributedString?
    @objc open var state: UIControl.State
    
    public init(value: NSAttributedString?, state: UIControl.State = UIControl.State()) {
        self.value = value
        self.state = state
    }

    public static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        guard let value = text else {
            return nil
        }
        if let values = service.parseKeyValueSequence(from: value, params: ["value", "state"]) {
            guard let attributed = values[0] as? NSAttributedString,
                  let state = values[1] as? UIControl.State else {
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

@objc open class ColorForState: NSObject, TextDeserializer {
    @objc open var value: UIColor?
    @objc open var state: UIControl.State

    public init(value: UIColor?, state: UIControl.State = UIControl.State()) {
        self.value = value
        self.state = state
    }

    public static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        guard let value = text else {
            return nil
        }
        if let values = service.parseKeyValueSequence(from: value, params: ["value", "state"]) {
            guard let color = values[0] as? UIColor,
                  let state = values[1] as? UIControl.State else {
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

@objc open class ImageForState: NSObject, TextDeserializer {
    @objc open var value: UIImage?
    @objc open var state: UIControl.State

    public init(value: UIImage?, state: UIControl.State = UIControl.State()) {
        self.value = value
        self.state = state
    }

    public static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        guard let value = text else {
            return nil
        }
        if let values = service.parseKeyValueSequence(from: value, params: ["value", "state"]) {
            guard let image = values[0] as? UIImage,
                  let state = values[1] as? UIControl.State else {
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

extension UIButton.ButtonType: NSValueConvertible {
    public func convertToNSValue() -> NSValue? {
        return NSNumber(value: self.rawValue as Int)
    }
}

open class ButtonType: Object, TextDeserializer {
    private static let ButtonTypeByText: [String: UIButton.ButtonType] = ["Custom": UIButton.ButtonType.custom,
                                                                   "System": UIButton.ButtonType.system,
                                                                   "DetailDisclosure": UIButton.ButtonType.detailDisclosure,
                                                                   "InfoLight": UIButton.ButtonType.infoLight,
                                                                   "InfoDark": UIButton.ButtonType.infoDark,
                                                                   "ContactAdd": UIButton.ButtonType.contactAdd,
                                                                   "RoundedRect": UIButton.ButtonType.roundedRect]

    public static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        guard let value = text else {
            return nil
        }
        return ButtonType.ButtonTypeByText[value]
    }
}
