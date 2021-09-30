//
//  UIView+Document.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 7/8/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

public extension UIView {
    @discardableResult
    func loadFromDocument(_ documentPath: String, builder: DocumentBuilder? = nil) -> Bool {
        let options = BuildOptions()
        options.instantiation = InstantiationOptions(instance: self)
        let builder = builder ?? DocumentBuilder.shared
        let instance = builder.loadView(documentPath, options: options)
        if instance != self {
            return false
        }
        return true
    }
}
