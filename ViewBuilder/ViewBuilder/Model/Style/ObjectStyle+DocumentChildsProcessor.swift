//
//  ObjectStyleChildProcessor.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 7/5/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

extension ObjectStyle: DocumentChildsProcessor {
    public func processDocument(childs: DocumentChildVisitor) {
        childs.visit { (child) -> Bool in
            if let setter = child as? Setter {
                add(setter: setter)
                return true
            }
            Log.shared.write("Warning: Instance = {\(child)} could not be part of object = {\(self)}.")
            return false
        }
    }
}
