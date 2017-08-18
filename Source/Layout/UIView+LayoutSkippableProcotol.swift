//
//  UIView+LayoutSkippableProcotol.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 11/28/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

extension UIView: LayoutSkippableProcotol {
    private static let LayoutSkippableProcotolCollapsedParameterName = "LayoutSkippableProcotolCollapsedParameterName"

    public var collapsable: Bool {
        get {
            guard let value = getAttachedParameter(UIView.LayoutSkippableProcotolCollapsedParameterName) as? Bool else {
                return true
            }
            return value
        }
        set {
            setAttachedParameter(UIView.LayoutSkippableProcotolCollapsedParameterName, value: newValue)
        }
    }

    private static let LayoutSkippableProcotolDetachedParameterName = "LayoutSkippableProcotolDetachedParameterName"

    public var detached: Bool {
        get {
            guard let value = getAttachedParameter(UIView.LayoutSkippableProcotolDetachedParameterName) as? Bool else {
                return false
            }
            return value
        }
        set {
            setAttachedParameter(UIView.LayoutSkippableProcotolDetachedParameterName, value: newValue)
        }
    }
}
