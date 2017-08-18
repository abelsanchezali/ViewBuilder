//
//  Mutable.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 7/24/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

open class Mutable: TextDeserializer {
    open static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        guard let text = text else {
            return nil
        }
        return service.parseValue(from: text)
    }

    open static func isDeserializedInstanceMutable() -> Bool {
        return true
    }
}
