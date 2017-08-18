//
//  Bundle.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 7/8/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

open class Bundle: Object, TextDeserializer {
    open static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        guard let value = text else {
            return nil
        }
        if let params = service.parseKeyValueSequence(from: value, params: ["identifier"]) {
            guard let identifier = params[0] as? String else {
                return nil
            }
            return Foundation.Bundle(identifier: identifier)
        }
        if let params = service.parseKeyValueSequence(from: value, params: ["path"]) {
            guard let path = params[0] as? String else {
                return nil
            }
            return Foundation.Bundle(path: path)
        }
        if let identifier = service.parseValue(from: value) as? String {
            return Foundation.Bundle(identifier: identifier)
        }
        return nil
    }
}

extension Foundation.Bundle: TextDeserializer {
    open static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        return Bundle.deserialize(text: text, service: service)
    }
}

