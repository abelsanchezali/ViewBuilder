//
//  UIView+BoxProtocol.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 11/28/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

extension UIView: BoxProtocol {
    private static let BoxProtocolMarginParameterName = "BoxProtocolMarginParameterName"
    
    @objc public var margin: UIEdgeInsets {
        get {
            guard let value = getAttachedParameter(UIView.BoxProtocolMarginParameterName) as? NSValue else {
                return UIEdgeInsets.zero
            }
            return value.uiEdgeInsetsValue
        }
        set {
            setAttachedParameter(UIView.BoxProtocolMarginParameterName, value: newValue.convertToNSValue())
        }
    }

    private static let BoxProtocolPaddingParameterName = "BoxProtocolPaddingParameterName"

    @objc public var padding: UIEdgeInsets {
        get {
            guard let value = getAttachedParameter(UIView.BoxProtocolPaddingParameterName) as? NSValue else {
                return UIEdgeInsets.zero
            }
            return value.uiEdgeInsetsValue
        }
        set {
            setAttachedParameter(UIView.BoxProtocolPaddingParameterName, value: newValue.convertToNSValue())
        }
    }

    private static let BoxProtocolPreferredSizeParameterName = "BoxProtocolPreferredSizeParameterName"

    @objc public var preferredSize: CGSize {
        get {
            guard let value = getAttachedParameter(UIView.BoxProtocolPreferredSizeParameterName) as? NSValue else {
                return CGSize(width: -1, height: -1)
            }
            return value.cgSizeValue
        }
        set {
            setAttachedParameter(UIView.BoxProtocolPreferredSizeParameterName, value: newValue.convertToNSValue())
        }
    }

    private static let BoxProtocolMaximumSizeParameterName = "BoxProtocolMaximumSizeParameterName"

    @objc public var maximumSize: CGSize {
        get {
            guard let value = getAttachedParameter(UIView.BoxProtocolMaximumSizeParameterName) as? NSValue else {
                return CGSize(width: -1, height: -1)
            }
            return value.cgSizeValue
        }
        set {
            setAttachedParameter(UIView.BoxProtocolMaximumSizeParameterName, value: newValue.convertToNSValue())
        }
    }
}
