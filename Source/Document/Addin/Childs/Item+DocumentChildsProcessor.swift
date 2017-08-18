//
//  Item+DocumentChildsProcessor.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 7/5/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

extension Item: DocumentChildsProcessor {
    public func processDocument(childs: DocumentChildVisitor) {
        self.value = childs.last
        if childs.count > 1 {
            Log.shared.write("Warning: Items should only have one child (\(childs.count)).")
        }
        childs.removeAll()
    }
}
