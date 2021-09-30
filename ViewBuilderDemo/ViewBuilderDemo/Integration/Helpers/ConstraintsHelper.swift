//
//  ConstraintsHelper.swift
//  ViewBuilderDemo
//
//  Created by Abel Sanchez on 6/28/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import ViewBuilder
import UIKit

public class ConstraintsHelper: NSObject {

    public class func fitViewInContainer(_ view: UIView, container: UIView, margin: UIEdgeInsets = UIEdgeInsets.zero) {
        view.translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        constraints.append(ConstraintsHelper.constraintViewAttribute(container,
            second: view,
            attribute: .leading,
            relation: .equal,
            priority: UILayoutPriority.required,
            constant: margin.left))
        constraints.append(ConstraintsHelper.constraintViewAttribute(view,
            second: container,
            attribute: .trailing,
            relation: .equal,
            priority: UILayoutPriority.required,
            constant: margin.right))
        constraints.append(ConstraintsHelper.constraintViewAttribute(container,
            second: view,
            attribute: .top,
            relation: .equal,
            priority: UILayoutPriority.required,
            constant: margin.top))
        constraints.append(ConstraintsHelper.constraintViewAttribute(view,
            second: container,
            attribute: .bottom,
            relation: .equal,
            priority: UILayoutPriority.required,
            constant: margin.bottom))
        container.addConstraints(constraints)
    }

  public class func constraintViewAttributes(_ first: UIView, firstAttribute: NSLayoutConstraint.Attribute, second: UIView, secondAttribute: NSLayoutConstraint.Attribute, constant: CGFloat) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: second, attribute: secondAttribute, relatedBy: .equal, toItem: first, attribute: firstAttribute, multiplier: 1, constant: constant)
        return constraint
    }

    public class func constraintViewAttribute(_ first: UIView, second: UIView, attribute: NSLayoutConstraint.Attribute, relation: NSLayoutConstraint.Relation, priority: UILayoutPriority, constant: CGFloat) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: second, attribute: attribute, relatedBy: relation, toItem: first, attribute: attribute, multiplier: 1, constant: constant)
        constraint.priority = priority
        return constraint
    }

    public class func constraintViewHeightToFit(_ view: UIView) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        constraint.priority = UILayoutPriority.fittingSizeLevel
        return constraint
    }

    public class func constraintViewWidthToFit(_ view: UIView) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        constraint.priority = UILayoutPriority.fittingSizeLevel
        return constraint
    }

    public class func constraintCenterXToContainer(_ view: UIView, container: UIView) -> NSLayoutConstraint {
        return constraintViewAttributes(view, firstAttribute: .centerX, second: container, secondAttribute: .centerX, constant: 0)
    }

    public class func constraintCenterYToContainer(_ view: UIView, container: UIView) -> NSLayoutConstraint {
        return constraintViewAttributes(view, firstAttribute: .centerY, second: container, secondAttribute: .centerY, constant: 0)
    }

    public class func horizontalAlignmentInContainer(_ view: UIView, container: UIView, alignment: LayoutAlignment, padding: UIEdgeInsets? = nil) -> [NSLayoutConstraint] {
        let padding = padding ?? container.padding
        var constraints = [NSLayoutConstraint]()
        switch alignment {
        case .center:
            constraints.append(constraintCenterXToContainer(view, container: container))
            constraints.append(constraintViewWidthToFit(view))
            constraints.append(constraintViewAttribute(container,
                second: view,
                attribute: .leading,
                relation: .greaterThanOrEqual,
                priority: UILayoutPriority.defaultHigh,
                constant: padding.left + view.margin.left))
            constraints.append(constraintViewAttribute(view,
                second: container,
                attribute: .trailing,
                relation: .greaterThanOrEqual,
                priority: UILayoutPriority.defaultHigh,
                constant: padding.right + view.margin.right))
            break
        case .minimum:
            constraints.append(constraintViewAttribute(container,
                second: view,
                attribute: .leading,
                relation: .equal,
                priority: UILayoutPriority.required,
                constant: padding.left + view.margin.left))
            constraints.append(constraintViewWidthToFit(view))
            constraints.append(constraintViewAttribute(view,
                second: container,
                attribute: .trailing,
                relation: .greaterThanOrEqual,
                priority: UILayoutPriority.defaultHigh,
                constant: padding.right + view.margin.right))
            break
        case .maximum:
            constraints.append(constraintViewAttribute(view,
                second: container,
                attribute: .trailing,
                relation: .equal,
                priority: UILayoutPriority.required,
                constant: padding.right + view.margin.right))
            constraints.append(constraintViewWidthToFit(view))
            constraints.append(constraintViewAttribute(container,
                second: view,
                attribute: .leading,
                relation: .greaterThanOrEqual,
                priority: UILayoutPriority.defaultHigh,
                constant: padding.left + view.margin.left))
            break
        case .stretch:
            constraints.append(constraintViewAttribute(container,
                second: view,
                attribute: .leading,
                relation: .equal,
                priority: UILayoutPriority.required,
                constant: padding.left + view.margin.left))
            constraints.append(constraintViewAttribute(view,
                second: container,
                attribute: .trailing,
                relation: .equal,
                priority: UILayoutPriority.required,
                constant: padding.right + view.margin.right))
            break
        }
        return constraints
    }

    public class func verticalAlignmentInContainer(_ view: UIView, container: UIView, alignment: LayoutAlignment, padding: UIEdgeInsets? = nil) -> [NSLayoutConstraint] {
        let padding = padding ?? container.padding
        var constraints = [NSLayoutConstraint]()
        switch alignment {
        case .center:
            constraints.append(constraintCenterYToContainer(view, container: container))
            constraints.append(constraintViewHeightToFit(view))
            constraints.append(constraintViewAttribute(container,
                second: view,
                attribute: .top,
                relation: .greaterThanOrEqual,
                priority: UILayoutPriority.defaultHigh,
                constant: padding.top + view.margin.top))
            constraints.append(constraintViewAttribute(view,
                second: container,
                attribute: .bottom,
                relation: .greaterThanOrEqual,
                priority: UILayoutPriority.defaultHigh,
                constant: padding.bottom + view.margin.bottom))
            break
        case .minimum:
            constraints.append(constraintViewAttribute(container,
                second: view,
                attribute: .top,
                relation: .equal,
                priority: UILayoutPriority.required,
                constant: padding.top + view.margin.top))
            constraints.append(constraintViewHeightToFit(view))
            constraints.append(constraintViewAttribute(view,
                second: container,
                attribute: .bottom,
                relation: .greaterThanOrEqual,
                priority: UILayoutPriority.defaultHigh,
                constant: padding.bottom + view.margin.bottom))
            break
        case .maximum:
            constraints.append(constraintViewAttribute(view,
                second: container,
                attribute: .bottom,
                relation: .equal,
                priority: UILayoutPriority.required,
                constant: padding.bottom + view.margin.bottom))
            constraints.append(constraintViewHeightToFit(view))
            constraints.append(constraintViewAttribute(container,
                second: view,
                attribute: .top,
                relation: .greaterThanOrEqual,
                priority: UILayoutPriority.defaultHigh,
                constant: padding.top + view.margin.top))
            break
        case .stretch:
            constraints.append(constraintViewAttribute(container,
                second: view,
                attribute: .top,
                relation: .equal,
                priority: UILayoutPriority.required,
                constant: padding.top + view.margin.top))
            constraints.append(constraintViewAttribute(view,
                second: container,
                attribute: .bottom,
                relation: .equal,
                priority: UILayoutPriority.required,
                constant: padding.bottom + view.margin.bottom))
            break
        }
        return constraints
    }


    public class func stackViewsInContainer(_ container: UIView, subviews: [UIView], orientation: LayoutOrientation, alignment: LayoutAlignment? = nil, padding: UIEdgeInsets? = nil) -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        let count = subviews.count
        var previous: UIView!
        let padding = padding ?? container.padding
        for index in 0..<count {
            let view = subviews[index]
            let isFirst = index == 0
            let isLast = index + 1 == count
            switch orientation {
            case .horizontal:
                if isFirst {
                    constraints.append(constraintViewAttributes(container,
                        firstAttribute: .leading,
                        second: view,
                        secondAttribute: .leading,
                        constant: padding.left + view.margin.left))
                } else {
                    constraints.append(constraintViewAttributes(previous,
                        firstAttribute: .trailing,
                        second: view,
                        secondAttribute: .leading,
                        constant: previous.margin.right + view.margin.left))
                }
                if isLast {
                    constraints.append(constraintViewAttributes(view,
                        firstAttribute: .trailing,
                        second: container,
                        secondAttribute: .trailing,
                        constant: padding.right + view.margin.right))
                }
                constraints.append(contentsOf: verticalAlignmentInContainer(view, container: container, alignment: alignment ?? view.verticalAlignment, padding: padding))
            case .vertical:
                if isFirst {
                    constraints.append(constraintViewAttributes(container,
                        firstAttribute: .top,
                        second: view,
                        secondAttribute: .top,
                        constant: padding.top + view.margin.top))
                } else {
                    constraints.append(constraintViewAttributes(previous,
                        firstAttribute: .bottom,
                        second: view,
                        secondAttribute: .top,
                        constant: previous.margin.bottom + view.margin.top))
                }
                if isLast {
                    constraints.append(constraintViewAttributes(view,
                        firstAttribute: .bottom,
                        second: container,
                        secondAttribute: .bottom,
                        constant: padding.bottom + view.margin.bottom))
                }
                constraints.append(contentsOf: horizontalAlignmentInContainer(view, container: container, alignment: alignment ?? view.horizontalAlignment, padding: padding))
                break
            }
            previous = view
        }

        return constraints
    }

}
