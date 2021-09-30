//
//  StackingViews.swift
//  ViewBuilderDemo
//
//  Created by Abel Sanchez on 7/5/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import ViewBuilder
import UIKit

public class StackingViews: UIViewAttachable {
    @objc public var padding: NSValue? = nil
    @objc public var orientation: LayoutOrientation = .vertical

    public var subviews = [UIView]()

    public override func add(item: Any) -> Bool {
        guard let view = item as? UIView else {
            return false
        }
        subviews.append(view)
        return true
    }

    public override func performAttachmentToView(_ view: UIView) {
        for subview in subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subview)
        }
        let constraints = ConstraintsHelper.stackViewsInContainer(view, subviews: subviews, orientation: orientation, alignment: nil, padding: padding?.uiEdgeInsetsValue)
        view.addConstraints(constraints)
    }
}
