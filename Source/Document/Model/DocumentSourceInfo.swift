//
//  DocumentSourceInfo.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 6/18/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

open class DocumentSourceInfo: NSObject {
    open let columnNumber: Int
    open let lineNumber: Int

    public required init(columnNumber: Int, lineNumber: Int) {
        self.columnNumber = columnNumber
        self.lineNumber = lineNumber
    }
}

// MARK: - CustomStringConvertible

extension DocumentSourceInfo {
    open override var description: String {
        get {
            return "{line = \(lineNumber), column = \(columnNumber)}"
        }
    }
}

