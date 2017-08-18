//
//  ShapeView.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 9/5/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

open class ShapeView: Panel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initialize() {
        shapeLayer = layer as! ShapeLayer
    }

    override open class var layerClass : AnyClass {
        return ShapeLayer.self
    }

    public private(set) var shapeLayer: ShapeLayer!

    open var pathBounds: CGRect {
        return shapeLayer.pathBoundingBox
    }

    open var data: String? {
        didSet {
            guard let value = data else {
                path = nil
                return
            }
            path = Path(data: value)
        }
    }

    open var path: Path? {
        didSet {
            shapeLayer.path = path?.path
            if fitToPath {
                bounds = pathBounds
                invalidateLayout()
            }
        }
    }

    open var fillColor: UIColor? {
        get {
            guard let color = shapeLayer.fillColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
        set {
            shapeLayer.fillColor = newValue != nil ? newValue!.cgColor : nil
        }
    }

    open var strokeColor: UIColor? {
        get {
            guard let color = shapeLayer.strokeColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
        set {
            shapeLayer.strokeColor = newValue != nil ? newValue!.cgColor : nil
        }
    }

    open var fillRule: String {
        get {
            return shapeLayer.fillRule
        }
        set {
            shapeLayer.fillRule = newValue
        }
    }

    open var fitToPath: Bool = true {
        didSet {
            if fitToPath {
                bounds = pathBounds
            }
            invalidateLayout()
        }
    }

    open override func measureOverride(_ size: CGSize) -> CGSize {
        let measuredSize = super.measureOverride(size)
        if fitToPath {
            let pathSize = pathBounds
            let padding = self.padding
            return CGSize(width: pathSize.width + padding.totalWidth, height: pathSize.height + padding.totalHeight)
        } else {
            return measuredSize
        }
    }
}
