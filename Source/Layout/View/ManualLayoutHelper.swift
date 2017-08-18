//
//  ManualLayoutHelper.swift
//  ViewBuilder
//
//  Created by Abel Sanchez on 8/13/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

extension CGFloat {
    public static let largeValue: CGFloat = 100000000
}

open class ManualLayoutHelper: NSObject {

    open class func linearLayout(_ size: CGFloat, before: CGFloat, after: CGFloat, available: CGFloat, alignment: LayoutAlignment) -> (CGFloat, CGFloat) {
        switch alignment {
        case .minimum:
            return (before, before + size)
        case .maximum:
            let start = available - size - after
            return (start, start + size)
        case .center:
            let start = (available - size + before - after) * 0.5
            return (start, start + size)
        case .stretch:
            return (before, available - after)
        }
    }

    open class func fitViewInContainer(_ view: UIView, container: UIView, margin: UIEdgeInsets = UIEdgeInsets.zero) {
        let margin = view.margin
        view.translatesAutoresizingMaskIntoConstraints = true
        view.autoresizesSubviews = true
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        let bounds = container.bounds
        let frame = CGRect(x: bounds.origin.x + margin.left,
                           y: bounds.origin.y + margin.top,
                           width: bounds.size.width - margin.totalWidth,
                           height: bounds.size.height - margin.totalHeight)
        view.frame = frame
    }
    
}
