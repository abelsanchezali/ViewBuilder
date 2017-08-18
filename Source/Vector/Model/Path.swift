//
//  Path.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 10/8/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import CoreGraphics

open class Path: NSObject {
    open let path: CGPath
    
    init(path: CGPath) {
        self.path = path
    }

    init?(data: String) {
        guard let path = VectorHelper.getPathFromSVGPathData(data: data) else {
            Log.shared.write("Warning: Invalid path format")
            return nil
        }
        self.path = path
    }
}

extension Path: TextDeserializer {
    public static func deserialize(text: String?, service: TextDeserializerServiceProtocol) -> Any? {
        guard let text = text else {
            Log.shared.write("Warning: Missing parameter")
            return nil
        }
        if let data = service.parseKeyValueSequence(from: text, params: ["data"]), let value = data[0] as? String {
            guard let path = VectorHelper.getPathFromSVGPathData(data: value) else {
                Log.shared.write("Warning: Invalid path format")
                return nil
            }
            return Path(path: path)
        }
        Log.shared.write("Warning: Invalid path")
        return nil
    }
}
