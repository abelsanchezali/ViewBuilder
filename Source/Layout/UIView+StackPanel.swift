//
//  UIView+StackPanel.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 1/11/17.
//  Copyright © 2017 Abel Sanchez. All rights reserved.
//

import UIKit

public extension UIView {
    private static let UIViewLayoutPriorityParameterName = "UIViewLayoutPriorityParameterName"

    public var priority: Double {
        get {
            guard let value = getAttachedParameter(UIView.UIViewLayoutPriorityParameterName) as? NSNumber else {
                return 0.0
            }
            return value.doubleValue
        }
        set {
            setAttachedParameter(UIView.UIViewLayoutPriorityParameterName, value: newValue)
        }
    }

    private static let UIViewLayoutFlexibilityParameterName = "UIViewLayoutFlexibilityParameterName"

    public var flexibility: Double {
        get {
            guard let value = getAttachedParameter(UIView.UIViewLayoutFlexibilityParameterName) as? NSNumber else {
                return 0.0
            }
            return value.doubleValue
        }
        set {
            setAttachedParameter(UIView.UIViewLayoutFlexibilityParameterName, value: newValue)
        }
    }

}
