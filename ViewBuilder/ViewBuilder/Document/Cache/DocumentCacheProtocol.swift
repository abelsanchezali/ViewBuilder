//
//  DocumentCacheProtocol.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 7/10/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

public protocol DocumentCacheProtocol: class {
    func getDocumentWithKey(_ key: AnyObject) -> DataDocument?
    func saveDocumentWithKey(_ key: AnyObject, document: DataDocument) -> Bool
    func removeDocumentWithKey(_ key: AnyObject) -> Bool
    func pruneCache()
}
