//
//  TextDeserializer.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 6/15/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

public protocol TextDeserializer {
    static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any?
    static func isDeserializedInstanceMutable() -> Bool
}

public extension TextDeserializer {
    static func isDeserializedInstanceMutable() -> Bool {
        return false
    }
}

public extension TextDeserializer {
    static func deserialize(text: String?) -> Any? {
        return deserialize(text: text, service: DefaultTextDeserializerService.shared)
    }
}

public extension DefaultTextDeserializerService {
    static let shared = DefaultTextDeserializerService()
}
