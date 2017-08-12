//
//  ShapeLayer.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 9/5/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

open class ShapeLayer: CAShapeLayer {

    open private(set) var pathBoundingBox: CGRect = CGRect.zero

    open func setPathData(_ data: String?) {
        path = VectorHelper.getPathFromSVGPathData(data: data)
    }

    override open var path: CGPath? {
        didSet {
            if let value = path {
                pathBoundingBox = value.boundingBoxOfPath
            } else {
                pathBoundingBox = CGRect.zero
            }
        }
    }
}
