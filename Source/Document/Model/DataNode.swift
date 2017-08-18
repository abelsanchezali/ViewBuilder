//
//  DataNode.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 6/9/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

public class DataNode: NSObject {

    public static let Empty = DataNode(name: "", domain: nil, parent: nil)

    public let parent: DataNode?

    public let name: String

    public let domain: String?

    public let hasPath: Bool

    public let path: String?

    public let attributes = MutableCollection<DataAttribute>()

    public let childs = MutableCollection<DataNode>()


    public var referenceType: AnyClass? = nil

    public var prefixes: DomainPrefixTable?

    public var debugInfo: DocumentSourceInfo?


    public required init(name: String, domain: String?, parent: DataNode? = nil) {
        if let index = name.range(of: Constants.Document.PathSeparator) {
            self.name = name.substring(to: index.lowerBound)
            self.path = name.substring(from: index.upperBound)
            self.hasPath = true
        } else {
            self.name = name
            self.path = nil
            self.hasPath = false
        }
        self.domain = domain
        self.parent = parent
    }

}

// MARK: - CustomStringConvertible

extension DataNode {
    open override var description: String {
        get {
            return "{\(domain == nil ? "" : "\(domain!).")\(name)\(hasPath ? ".\(path!)" : ""), attributes = \(attributes.count), childs = \(childs.count)\(debugInfo == nil ? "" : ", source = \(debugInfo!)")}"
        }
    }
}

// MARK: -

public extension DataNode {

    public func findFirstNodeMatching(_ predicate: (_ n: DataNode) -> Bool) -> DataNode? {
        if predicate(self) {
            return self
        }
        for child in self.childs {
            if let n = child.findFirstNodeMatching(predicate) {
                return n
            }
        }
        return nil
    }

    public func findFirstNodeWithName(_ name: String) -> DataNode? {
        return findFirstNodeMatching() { $0.name == name }
    }

    public func findFirstNodeWithNameAndDomain(_ name: String, domain: String) -> DataNode? {
        return findFirstNodeMatching() { $0.name == name && $0.domain == domain }
    }

    public func findChildNodeMatching(_ predicate: (_ n: DataNode) -> Bool) -> DataNode? {
        for child in self.childs {
            if predicate(child) {
                return child
            }
        }
        return nil
    }

    public func findChildNodeWithName(_ name: String) -> DataNode? {
        return findChildNodeMatching() { $0.name == name }
    }

    public func findChildNodeWithNameAndDomain(_ name: String, domain: String) -> DataNode? {
        return findChildNodeMatching() { $0.name == name && $0.domain == domain }
    }
}






