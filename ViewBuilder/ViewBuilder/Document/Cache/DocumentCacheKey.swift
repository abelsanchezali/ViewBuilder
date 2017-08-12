//
//  DocumentCacheKey.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 8/2/17.
//  Copyright © 2017 Abel Sanchez. All rights reserved.
//

import Foundation

/// Internal class used as key for documents in cache
class DocumentCacheKey: NSObject {
    let path: String
    let includeParsingInfo: Bool
    let namespaces: [String: String]

    private let storedHash: Int

    init(path: String, namespaces: [String: String], includeParsingInfo: Bool) {
        self.path = path
        self.namespaces = namespaces
        self.includeParsingInfo = includeParsingInfo
        storedHash = HashHelper.computeHash([
            path.hashValue,
            HashHelper.computeHash([String](namespaces.keys)),
            HashHelper.computeHash([String](namespaces.values)),
            includeParsingInfo.hashValue])
    }

    override var hash: Int {
        return storedHash
    }

    override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? DocumentCacheKey else {
            return false
        }
        return self == other
    }
}

private func ==(lhs: DocumentCacheKey, rhs: DocumentCacheKey) -> Bool {
    return lhs.path == rhs.path && lhs.namespaces == rhs.namespaces && lhs.includeParsingInfo == rhs.includeParsingInfo
}
