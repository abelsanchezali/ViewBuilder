//
//  Foundation+DocumentChildsProcessor.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 9/11/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

extension NSMutableArray: DocumentChildsProcessor {
    public func processDocument(childs: DocumentChildVisitor) {
        childs.visit { (child) -> Bool in
            add(child)
            return true
        }
    }
}
