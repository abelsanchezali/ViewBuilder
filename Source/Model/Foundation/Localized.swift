//
//  Localized.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 10/16/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

open class Localized: NSObject, TextDeserializer {
    public static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        guard let text = text else {
            Log.shared.write("Warning: Missing parameter")
            return nil
        }
        if let data = service.parseKeyValueSequence(from: text, params: ["key", "tableName", "bundle", "value", "comment"]) {
            let key = data[0] as? String
            let tableName = data[1] as? String
            let bundle = data[2] as? Foundation.Bundle
            let value = data[3] as? String
            let comment = data[4] as? String
            return deserializeWithParameters(service, key: key, tableName: tableName, bundle: bundle, value: value, comment: comment)
        }
        if let data = service.parseKeyValueSequence(from: text, params: ["key", "bundle", "tableName"]) {
            let key = data[0] as? String
            let bundle = data[1] as? Foundation.Bundle
            let tableName = data[2] as? String
            return deserializeWithParameters(service, key: key, tableName: tableName, bundle: bundle, value: nil, comment: nil)
        }
        if let data = service.parseKeyValueSequence(from: text, params: ["key", "bundle"]) {
            let key = data[0] as? String
            let bundle = data[1] as? Foundation.Bundle
            return deserializeWithParameters(service, key: key, tableName: nil, bundle: bundle, value: nil, comment: nil)
        }
        if let data = service.parseKeyValueSequence(from: text, params: ["key"]) {
            let key = data[0] as? String
            return deserializeWithParameters(service, key: key, tableName: nil, bundle: nil, value: nil, comment: nil)
        }
        return deserializeWithParameters(service, key: text, tableName: nil, bundle: nil, value: nil, comment: nil)
    }

    private static func deserializeWithParameters(_ service: TextDeserializerServiceProtocol, key: String?, tableName: String?, bundle: Foundation.Bundle?, value: String?, comment: String?) -> String? {
        guard let key = key else {
            Log.shared.write("Warning: Missing 'key'")
            return nil
        }
        let bundle = bundle ?? Foundation.Bundle.main
        let comment = comment ?? ""
        let value = value ?? ""
        return NSLocalizedString(key, tableName: tableName, bundle: bundle, value: value, comment: comment)
    }
}

