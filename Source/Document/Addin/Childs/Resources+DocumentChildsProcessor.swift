//
//  Resources+DocumentChildsProcessor.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 6/24/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

extension Resources: DocumentChildsProcessor {
    public func processDocument(childs: DocumentChildVisitor) {
        var items = [Item]()
        childs.visit { (child) -> Bool in
            switch child {
            case let item as Item:
                items.append(item)
                return true
            case let resource as Resources:
                self.mergeWithResource(resource)
                return true
            default:
                return false
            }
        }
        self.addItems(items)
    }
}
