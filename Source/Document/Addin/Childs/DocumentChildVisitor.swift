//
//  DocumentChildVisitor.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 8/10/17.
//  Copyright © 2017 Abel Sanchez. All rights reserved.
//

import Foundation

public class DocumentChildVisitor: NSObject {
    var collection: [Any]

    init(childs: [Any]) {
        collection = childs
    }

    public func visit(block: (Any) -> Bool) {
        var index = 0
        while index < collection.count {
            if block(collection[index]) {
                collection.remove(at: index)
            } else {
                index = index + 1
            }
        }
    }

    public var count: Int {
        get {
            return collection.count
        }
    }

    public var last: Any? {
        get {
            return collection.last
        }
    }

    public var first: Any? {
        get {
            return collection.first
        }
    }

    public func removeAll() {
        collection.removeAll()
    }
}
