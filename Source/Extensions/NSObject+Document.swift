//
//  NSObject+Document.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 7/9/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

public extension NSObject {
    private struct AssociatedKeys {
        static var NSObjectDocumentReferencesName = "NSObjectDocumentReferencesParameterName"
    }
    
    var documentReferences: [String: Any]? {
        get {
            let dict = objc_getAssociatedObject(self, &AssociatedKeys.NSObjectDocumentReferencesName) as? [String: Any]
            return dict
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.NSObjectDocumentReferencesName, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
