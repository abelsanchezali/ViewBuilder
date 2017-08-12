//
//  UIView+PanelLayoutProtocol.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 8/9/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

extension UIView: PanelLayoutProtocol {
    private static let PanelLayoutProtocolMeasuredSizeParameterName = "PanelLayoutProtocolMeasuredSizeParameterName"

    public var measuredSize: CGSize {
        get {
            guard let value = getAttachedParameter(UIView.PanelLayoutProtocolMeasuredSizeParameterName) as? NSValue else {
                return CGSize.zero
            }
            return value.cgSizeValue
        }
        set {
            setAttachedParameter(UIView.PanelLayoutProtocolMeasuredSizeParameterName, value: newValue.convertToNSValue())
        }
    }

    public func measureOverride(_ size: CGSize) -> CGSize {
        if translatesAutoresizingMaskIntoConstraints {
            return sizeThatFits(size)
        } else {
            return systemLayoutSizeFitting(size)
        }
    }

    public func subviewMeasureChanged(_ subview: UIView) {

    }

    public func invalidateMeasure() {
        superview?.subviewMeasureChanged(self)
    }

    public func arrangeToRect(_ rect: CGRect) {
        // TODO: Add RTL support here

        // EYE: Don't do this way
        //frame = rect
        let anchor = layer.anchorPoint
        bounds = CGRect(origin: bounds.origin, size: rect.size)
        center = CGPoint(x: rect.origin.x + rect.size.width * anchor.x,
                         y: rect.origin.y + rect.size.height * anchor.y)
    }
}
