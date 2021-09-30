//
//  UIViewAttachable.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 7/4/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

open class UIViewAttachable: AttachableObject {
    open override func add(item: Any) -> Bool {
        return false
    }
    
    open override func canBeAttached(to instance: Any) -> Bool {
        return type(of: instance) is UIView.Type
    }
    
    open override func performAttachment(to instance: Any) {
        guard let view = instance as? UIView else {
            Log.shared.write("Warning: UIViewAttachable expected UIView but received type = {\(type(of: instance))}.")
            return
        }
        performAttachmentToView(view)
    }
    
    open func performAttachmentToView(_ view: UIView) {
        
    }
}
