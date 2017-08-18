//
//  Nib.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 7/8/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

open class Nib: NSObject, TextDeserializer {
    open let name: String
    open let bundle: Foundation.Bundle

    public required init(name: String, bundle: Foundation.Bundle = Foundation.Bundle.main) {
        self.name = name
        self.bundle = bundle
    }

    open static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        guard let value = text else {
            return nil
        }
        if let values = service.parseKeyValueSequence(from: value, params: ["name", "bundle"]) {
            guard let name = values[0] as? String,
                      let bundle = values[1] as? Foundation.Bundle else {
                    return nil
            }
            return Nib(name: name, bundle: bundle)
        }
        if let values = service.parseKeyValueSequence(from: value, params: ["name", "identifier"]) {
            guard let name = values[0] as? String,
                let identifier = values[1] as? String else {
                    return nil
            }
            guard let bundle = Foundation.Bundle(identifier: identifier) else {
                return nil
            }
            return Nib(name: name, bundle: bundle)
        }
        return Nib(name: value)
    }
}
