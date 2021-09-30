//
//  LinearGradientView.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 7/24/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

open class GradientStop: NSObject, DefaultConstructor {
    @objc open var color: UIColor
  @objc open var offset: Double

    public override required init() {
        color = UIColor.clear
        offset = 1
    }
}

open class LinearGradientView: UIView {

    override open class var layerClass : AnyClass {
        return CAGradientLayer.self
    }

    public override init(frame: CGRect) {
        stops = nil
        startPoint = CGPoint(x: 0, y: 0)
        endPoint = CGPoint(x: 1, y: 1)
        super.init(frame: frame)
    }

    public required init?(coder aDecoder: NSCoder) {
        stops = nil
        startPoint = CGPoint(x: 0, y: 0)
        endPoint = CGPoint(x: 1, y: 1)
        super.init(coder: aDecoder)
    }

  @objc open var stops: [GradientStop]? {
        didSet {
            guard let gradientLayer = layer as? CAGradientLayer else {
                return
            }
            var colors: [AnyObject]? = nil
            var locations: [NSNumber]? = nil
            if var stops = self.stops {
                // Sort gradients stop monotonically increasing as required in CAGradientLayer
                stops.sort() { $0.offset < $1.offset }
                colors = stops.map { $0.color.cgColor }
                locations = stops.map { NSNumber(value: $0.offset as Double) }
            }
            gradientLayer.colors = colors
            gradientLayer.locations = locations
        }
    }

  @objc open var startPoint: CGPoint {
        didSet {
            guard let gradientLayer = layer as? CAGradientLayer else {
                return
            }
            gradientLayer.startPoint = startPoint
        }
    }

  @objc open var endPoint: CGPoint {
        didSet {
            guard let gradientLayer = layer as? CAGradientLayer else {
                return
            }
            gradientLayer.endPoint = endPoint
        }
    }

    // MARK: - DocumentChildsProcessor

    open override func processDocument(childs: DocumentChildVisitor) {
        super.processDocument(childs: childs)
        var stops = [GradientStop]()
        childs.visit { (child) -> Bool in
            if let stop = child as? GradientStop {
                stops.append(stop)
                return true
            }
            return false
        }
        self.stops = stops
    }
}
