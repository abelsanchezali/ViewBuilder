//
//  UIViewConstructor.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 6/11/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

open class UIViewConstructor: ObjectConstructor {
    private static let NibParameter = "nib"
    private static let DocumentParameter = "document"
    private static let Parameters = [UIViewConstructor.NibParameter, UIViewConstructor.DocumentParameter]

    open func parametersKeys() -> [String] {
        return UIViewConstructor.Parameters
    }

    open func createObject(with parameters: [String: Any], objectType: AnyClass, builder: DocumentBuilder) -> Any? {
        guard let type = objectType as? UIView.Type else {
            return nil
        }
        if let nib = parameters[UIViewConstructor.NibParameter] as? Nib {
            return UIKitHelper.loadViewFromNibName(nib.name, bundle: nib.bundle, viewType: type)
        }
        if let documentPath = parameters[UIViewConstructor.DocumentParameter] as? String {
            return builder.loadView(documentPath)
        }
        return type.init()
    }
}

extension UIView: ObjectConstructorProvider {
    private static let objectConstructor = UIViewConstructor()

    public dynamic class func resolveObjectConstructor() -> ObjectConstructor {
        return UIView.objectConstructor
    }
}
