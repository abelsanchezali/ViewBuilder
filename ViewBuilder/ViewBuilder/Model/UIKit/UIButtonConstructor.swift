//
//  UIButtonConstructor.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 6/11/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import Foundation

open class UIButtonConstructor: ObjectConstructor {
    private static let UIButtonTypeParameter = "type"
    private static let Parameters = [UIButtonConstructor.UIButtonTypeParameter]

    open func parametersKeys() -> [String] {
        return UIButtonConstructor.Parameters
    }

    open func createObject(with parameters: [String: Any], objectType: AnyClass, builder: DocumentBuilder) -> Any? {
        guard let type = objectType as? UIButton.Type else {
            return nil
        }
        if let buttonType = parameters[UIButtonConstructor.UIButtonTypeParameter] as? UIButtonType {
            return type.init(type: buttonType)
        }
        return type.init(type: UIButtonType.system)
    }
}

extension UIButton {
    private static let objectConstructor = UIButtonConstructor()

    public override class func resolveObjectConstructor() -> ObjectConstructor {
        return UIButton.objectConstructor
    }
}

