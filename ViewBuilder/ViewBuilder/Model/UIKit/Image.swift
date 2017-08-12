//
//  Image.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 7/8/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

open class Image: Object, TextDeserializer {
    open static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        guard let value = text else {
            return nil
        }

        // UIImage(named: String, inBundle: NSBundle?, compatibleWithTraitCollection: UITraitCollection?)
        if let params = service.parseKeyValueSequence(from: value, params: ["named", "bundle"]) {
            guard let name = params[0] as? String,
                      let bundle = params[1] as? Foundation.Bundle else {
                return nil
            }
            return UIImage(named: name, in: bundle, compatibleWith: nil)
        }
        // UIImage(named: String)
        if let params = service.parseKeyValueSequence(from: value, params: ["named"]) {
            guard let name = params[0] as? String else {
                return nil
            }
            return UIImage(named: name)
        }
        // UIImage(contentsOfFile: String)
        if let params = service.parseKeyValueSequence(from: value, params: ["path"]) {
            guard let path = params[0] as? String else {
                return nil
            }
            return UIImage(contentsOfFile: path)
        }
        if let name = service.parseValue(from: value) as? String {
            return UIImage(named: name)
        }
        return nil
    }
}

extension UIImage: TextDeserializer {
    public static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        return Image.deserialize(text: text, service: service)
    }
}
