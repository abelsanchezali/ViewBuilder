//
//  DefaultDocumentCache.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 7/10/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

@objc open class DefaultDocumentCache: NSObject, DocumentCacheProtocol, NSCacheDelegate {

    let cache: NSCache<AnyObject, AnyObject>

    public override init() {
        cache = NSCache()
        super.init()
        cache.delegate = self
    }

    // MARK: NSCacheDelegate

    open func cache(_ cache: NSCache<AnyObject, AnyObject>, willEvictObject obj: Any) {
        Log.shared.write("Removing Document from cache \(obj)")
    }

    //MARK: DocumentCacheProtocol

    open func getDocumentWithKey(_ key: AnyObject) -> DataDocument? {
        return cache.object(forKey: key) as? DataDocument
    }

    open func saveDocumentWithKey(_ key: AnyObject, document: DataDocument) -> Bool {
        cache.setObject(document, forKey: key)
        return true
    }

    open func removeDocumentWithKey(_ key: AnyObject) -> Bool {
        cache.removeObject(forKey: key)
        return true
    }

    open func pruneCache() {
        cache.removeAllObjects()
    }

}
