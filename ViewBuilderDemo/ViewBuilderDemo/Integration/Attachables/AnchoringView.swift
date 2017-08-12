//
//  AnchoringView.swift
//  ViewBuilderDemo
//
//  Created by Abel Sanchez on 7/4/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import ViewBuilder

public class AnchoringView: UIViewAttachable {
    public var subview: UIView?
    public var margin: NSValue? = nil
    public var anchor: NSNumber? = NSNumber(value: LayoutAnchor.fill.rawValue as Int)

    public override func add(item: Any) -> Bool {
        guard let view = item as? UIView else {
            return false
        }
        subview = view
        return true
    }

    public override func performAttachmentToView(_ view: UIView) {
        guard let subview = subview else {
            Log.shared.write("Warning: Missing subview to attach to {\(view)}")
            return
        }
        let margin = self.margin?.uiEdgeInsetsValue ?? subview.margin
        let anchor = LayoutAnchor(rawValue:self.anchor?.intValue ?? 0)
        subview.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subview)
        var constraints = [NSLayoutConstraint]()

        if anchor.contains(.centerX) {
            constraints.append(ConstraintsHelper.constraintViewAttribute(view,
                second: subview,
                attribute: .centerX,
                relation: .equal,
                priority: UILayoutPriorityRequired,
                constant: margin.left - margin.right))
        } else {
            if anchor.contains(.left) {
                constraints.append(ConstraintsHelper.constraintViewAttribute(view,
                    second: subview,
                    attribute: .leading,
                    relation: .equal,
                    priority: UILayoutPriorityRequired,
                    constant: margin.left))
            }
            if anchor.contains(.right) {
                constraints.append(ConstraintsHelper.constraintViewAttribute(subview,
                    second: view,
                    attribute: .trailing,
                    relation: .equal,
                    priority: UILayoutPriorityRequired,
                    constant: margin.right))
            }
        }
        if anchor.contains(.centerY) {
            constraints.append(ConstraintsHelper.constraintViewAttribute(view,
                second: subview,
                attribute: .centerY,
                relation: .equal,
                priority: UILayoutPriorityRequired,
                constant: margin.top - margin.bottom))
        } else {
            if anchor.contains(.top) {
                constraints.append(ConstraintsHelper.constraintViewAttribute(view,
                    second: subview,
                    attribute: .top,
                    relation: .equal,
                    priority: UILayoutPriorityRequired,
                    constant: margin.top))
            }
            if anchor.contains(.bottom) {
                constraints.append(ConstraintsHelper.constraintViewAttribute(subview,
                    second: view,
                    attribute: .bottom,
                    relation: .equal,
                    priority: UILayoutPriorityRequired,
                    constant: margin.bottom))
            }
        }
        view.addConstraints(constraints)
    }
}
