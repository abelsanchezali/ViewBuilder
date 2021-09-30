//
//  UIView+Alignment.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 6/28/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

public extension UIView {
    private static let UIViewLayoutVerticalAlignmentLayoutParameterName = "UIViewLayoutVerticalAlignmentLayoutParameterName"

    @objc var verticalAlignment: LayoutAlignment {
        get {
            guard let value = getAttachedParameter(UIView.UIViewLayoutVerticalAlignmentLayoutParameterName) as? NSNumber else {
                return .minimum
            }
            return LayoutAlignment(rawValue: value.intValue)!
        }
        set {
             setAttachedParameter(UIView.UIViewLayoutVerticalAlignmentLayoutParameterName, value: newValue.convertToNSValue())
        }
    }

    private static let UIViewLayoutHorizontalAlignmentLayoutParameterName = "UIViewLayoutHorizontalAlignmentLayoutParameterName"
    
    @objc var horizontalAlignment: LayoutAlignment {
        get {
            guard let value = getAttachedParameter(UIView.UIViewLayoutHorizontalAlignmentLayoutParameterName) as? NSNumber else {
                return .minimum
            }
            return LayoutAlignment(rawValue: value.intValue)!
        }
        set {
            setAttachedParameter(UIView.UIViewLayoutHorizontalAlignmentLayoutParameterName, value: newValue.convertToNSValue())
        }
    }
}


