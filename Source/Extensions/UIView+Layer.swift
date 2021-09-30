//
//  UIView+Layer.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 7/5/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

public extension UIView {

    @objc var borderColor: UIColor? {
        get {
            guard let cgColor = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: cgColor)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    @objc var borderWidth: Double {
        get {
            return Double(layer.borderWidth)
        }
        set {
            layer.borderWidth = CGFloat(newValue)
        }
    }


    @objc var cornerRadius: Double {
        get {
            return Double(layer.cornerRadius)
        }
        set {
            layer.cornerRadius = CGFloat(newValue)
        }
    }

    @objc var masksToBounds: Bool {
        get {
            return layer.masksToBounds
        }
        set {
            layer.masksToBounds = newValue
        }
    }


    @objc var shadowRadius: Double {
        get {
            return Double(layer.shadowRadius)
        }
        set {
            layer.shadowRadius = CGFloat(newValue)
        }
    }

    @objc var shadowColor: UIColor? {
        get {
            guard let cgColor = layer.shadowColor else {
                return nil
            }
            return UIColor(cgColor: cgColor)
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }

    @objc var shadowOpacity: Double {
        get {
            return Double(layer.shadowOpacity)
        }
        set {
            layer.shadowOpacity = Float(newValue)
        }
    }

    @objc var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }

    @objc var shouldRasterize: Bool {
        get {
            return layer.shouldRasterize
        }
        set {
            layer.shouldRasterize = newValue
        }
    }
    
    @objc var rasterizationScale: Double {
        get {
            let scale = (self.window?.screen ?? UIScreen.main).scale
            return Double(layer.rasterizationScale / scale)
        }
        set {
            let scale = (self.window?.screen ?? UIScreen.main).scale
            layer.rasterizationScale = CGFloat(newValue) * scale
        }
    }
}
