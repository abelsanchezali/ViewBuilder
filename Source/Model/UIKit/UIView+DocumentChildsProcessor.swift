//
//  UIViewChildProcessor.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 6/12/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

extension UIView: DocumentChildsProcessor {
    open func processDocument(childs: DocumentChildVisitor) {
        var subviews = [UIView]()
        var layers = [CALayer]()
        var constraints = [NSLayoutConstraint]()
        childs.visit { (child) -> Bool in
            switch child {
            case let view as UIView:
                subviews.append(view)
                return true
            case let layer as CALayer:
                layers.append(layer)
                return true
            case let constraint as NSLayoutConstraint:
                constraints.append(constraint)
                return true
            default:
                return false
            }
        }
        subviews.forEach(addSubview)
        layers.forEach(layer.addSublayer)
        addConstraints(constraints)
    }
}
