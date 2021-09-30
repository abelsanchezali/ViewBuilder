//
//  DataAttribute.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 6/12/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

public enum DataAttributeUsage {
    case property
    case constructor
    case invalid
    case attached
    case parameter
}

public class DataAttribute: NSObject {

    public let domain: String?

    public let name: String

    public let text: String

    public let hasPath: Bool


    public var finalValue: Any?

    public var usage: DataAttributeUsage = .property

    public var debugInfo: DocumentSourceInfo?
    
    
    public required init(domain: String?, name: String, text: String) {
        self.domain = domain
        self.name = name
        self.hasPath = name.contains(Constants.Document.PathSeparator)
        self.text = text
    }
}


// MARK: - CustomStringConvertible

extension DataAttribute {
    open override var description: String {
        get {
            return "{name = \(name), text = \(text)\(debugInfo == nil ? "" : ", source = \(debugInfo!)")}"
        }
    }
}
