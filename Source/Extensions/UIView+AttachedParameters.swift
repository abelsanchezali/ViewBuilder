//
//  UIView+AttachedParameters.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 11/28/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

public extension UIView {
    private class DataHolder {
        var data = [String: Any]()
    }

    private struct AssociatedKeys {
        static var UIViewLayoutParametersParameterName = "UIViewLayoutParametersParameterName"
    }

    private var attachedParameters: DataHolder {
        get {
            var dict = objc_getAssociatedObject(self, &AssociatedKeys.UIViewLayoutParametersParameterName) as? DataHolder
            if dict == nil {
                dict = DataHolder()
                objc_setAssociatedObject(self, &AssociatedKeys.UIViewLayoutParametersParameterName, dict!, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
            return dict!
        }
    }

    public final func setAttachedParameter(_ key: String, value: Any?) {
        if let value = value {
            attachedParameters.data[key] = value
        } else {
            attachedParameters.data.removeValue(forKey: key)
        }
    }

    public final func getAttachedParameter(_ key: String) -> Any? {
        return attachedParameters.data[key]
    }
}
