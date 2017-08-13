//
//  AttachableObject+DocumentChildsProcessor.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 7/4/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

extension AttachableObject: DocumentChildsProcessor {
    public func processDocument(childs: DocumentChildVisitor) {
        childs.visit { (child) -> Bool in
            if add(item: child) {
                return true
            } else {
                Log.shared.write("Warning: Instance = {\(child)} could not be part of object = {\(self)}.")
                return false
            }
        }
    }
}
