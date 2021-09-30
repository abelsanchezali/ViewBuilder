//
//  Text.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 7/8/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

open class Text: Object, TextDeserializer {
    public static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        return text
    }
}
