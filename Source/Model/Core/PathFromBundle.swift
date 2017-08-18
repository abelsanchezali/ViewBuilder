//
//  PathFromBundle.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 6/25/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

open class PathFromBundle: Object, TextDeserializer {
    open static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        guard let value = text else {
            return nil
        }
        // Resolve path:<path> identifier:<identifier>
        if let params = service.parseKeyValueSequence(from: value, params: ["path", "identifier"]) {
            guard let path = params[0] as? String, let identifier = params[1] as? String else {
                return nil
            }
            return resolvePathFromBundle(resourcePath: path, bundle: Foundation.Bundle(identifier: identifier))
        }
        // Only one parameter will handled as path
        if let chunks = service.parseValueSequence(from: value), chunks.count == 1, let path = chunks[0] as? String {
            return resolvePathFromBundle(resourcePath: path)
        }
        return nil
    }
    
    static func resolvePathFromBundle(resourcePath: String, bundle: Foundation.Bundle? = Foundation.Bundle.main) -> String? {
        guard let url = URL(string: resourcePath) else {
            return nil
        }
        let normalizedPath = url.path
        guard !normalizedPath.isEmpty else {
            return nil
        }
        
        let targetBundle = bundle ?? Foundation.Bundle.main
        
        let fileName = url.lastPathComponent
        guard !fileName.isEmpty else {
            return nil
        }
        
        let directory = normalizedPath.substring(to: normalizedPath.characters.index(normalizedPath.endIndex, offsetBy: -fileName.characters.count)).trimmingCharacters(in: CharacterSet(charactersIn: "/\\"))
        
        let result = targetBundle.path(forResource: fileName, ofType: nil, inDirectory: directory)
        return result
    }
}
