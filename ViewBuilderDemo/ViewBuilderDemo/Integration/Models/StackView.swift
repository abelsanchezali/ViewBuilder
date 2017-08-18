//
//  StackView.swift
//  ViewBuilderDemo
//
//  Created by Abel Sanchez on 6/28/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import ViewBuilder
import UIKit

// MARK: - UIView extensions

internal extension UIView {

    private static let StackViewLeadingConstraintParameterName = "StackViewLeadingConstraintParameterName"

    var leadingConstraint: NSLayoutConstraint? {
        get {
            guard let value = getAttachedParameter(UIView.StackViewLeadingConstraintParameterName) as? NSLayoutConstraint else {
                return nil
            }
            return value
        }
        set {
            setAttachedParameter(UIView.StackViewLeadingConstraintParameterName, value: newValue)
        }
    }

    private static let StackViewTrainlingConstraintParameterName = "StackViewTrainlingConstraintParameterName"

    var trailingConstraint: NSLayoutConstraint? {
        get {
            guard let value = getAttachedParameter(UIView.StackViewTrainlingConstraintParameterName) as? NSLayoutConstraint else {
                return nil
            }
            return value
        }
        set {
            setAttachedParameter(UIView.StackViewTrainlingConstraintParameterName, value: newValue)
        }
    }

    private static let StackViewTopConstraintParameterName = "StackViewTopConstraintParameterName"

    var topConstraint: NSLayoutConstraint? {
        get {
            guard let value = getAttachedParameter(UIView.StackViewTopConstraintParameterName) as? NSLayoutConstraint else {
                return nil
            }
            return value
        }
        set {
            setAttachedParameter(UIView.StackViewTopConstraintParameterName, value: newValue)
        }
    }

    private static let StackViewBottomConstraintParameterName = "StackViewBottomConstraintParameterName"

    var bottomConstraint: NSLayoutConstraint? {
        get {
            guard let value = getAttachedParameter(UIView.StackViewBottomConstraintParameterName) as? NSLayoutConstraint else {
                return nil
            }
            return value
        }
        set {
            setAttachedParameter(UIView.StackViewBottomConstraintParameterName, value: newValue)
        }
    }

    private static let StackViewWidthConstraintParameterName = "StackViewWidthConstraintParameterName"

    var widthConstraint: NSLayoutConstraint? {
        get {
            guard let value = getAttachedParameter(UIView.StackViewWidthConstraintParameterName) as? NSLayoutConstraint else {
                return nil
            }
            return value
        }
        set {
            setAttachedParameter(UIView.StackViewWidthConstraintParameterName, value: newValue)
        }
    }

    private static let StackViewHeightConstraintParameterName = "StackViewHeightConstraintParameterName"

    var heightConstraint: NSLayoutConstraint? {
        get {
            guard let value = getAttachedParameter(UIView.StackViewHeightConstraintParameterName) as? NSLayoutConstraint else {
                return nil
            }
            return value
        }
        set {
            setAttachedParameter(UIView.StackViewHeightConstraintParameterName, value: newValue)
        }
    }

    private static let StackViewCenterXConstraintParameterName = "StackViewCenterXConstraintParameterName"

    var centerXConstraint: NSLayoutConstraint? {
        get {
            guard let value = getAttachedParameter(UIView.StackViewCenterXConstraintParameterName) as? NSLayoutConstraint else {
                return nil
            }
            return value
        }
        set {
            setAttachedParameter(UIView.StackViewCenterXConstraintParameterName, value: newValue)
        }
    }

    private static let StackViewCenterYConstraintParameterName = "StackViewCenterYConstraintParameterName"

    var centerYConstraint: NSLayoutConstraint? {
        get {
            guard let value = getAttachedParameter(UIView.StackViewCenterYConstraintParameterName) as? NSLayoutConstraint else {
                return nil
            }
            return value
        }
        set {
            setAttachedParameter(UIView.StackViewCenterYConstraintParameterName, value: newValue)
        }
    }
}

public class StackView: UIView {
    // MARK: - Constructor 

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }

    func initialize() {
        addObserver(self, forKeyPath: "padding", options: .new, context: nil)
    }

    deinit {
        removeObserver(self, forKeyPath: "padding")
    }

    // MARK: - Properties

    public var orientation: LayoutOrientation = .vertical {
        didSet {
            setNeedsUpdateConstraints()
        }
    }

    private var isDirtyConstraints = true

    // MARK: -

    public override class var requiresConstraintBasedLayout : Bool {
        return true
    }


    override public class var layerClass : AnyClass {
        return CATransformLayer.self
    }

    // MARK: - 

    @discardableResult private func removeConstraintForView(_ constraint: NSLayoutConstraint?) -> NSLayoutConstraint? {
        guard let constraint = constraint else {
            return nil
        }
        removeConstraint(constraint)
        return nil
    }

    private func clearConstraintsForView(_ view: UIView) {
        view.leadingConstraint = removeConstraintForView(view.leadingConstraint)
        view.trailingConstraint = removeConstraintForView(view.trailingConstraint)
        view.topConstraint = removeConstraintForView(view.topConstraint)
        view.bottomConstraint = removeConstraintForView(view.bottomConstraint)
        view.widthConstraint = removeConstraintForView(view.widthConstraint)
        view.heightConstraint = removeConstraintForView(view.heightConstraint)
        view.centerXConstraint = removeConstraintForView(view.centerXConstraint)
        view.centerYConstraint = removeConstraintForView(view.centerYConstraint)
    }

    private func connectToView(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addObserver(self, forKeyPath: "margin", options: .new, context: nil)
        view.addObserver(self, forKeyPath: "collapsable", options: .new, context: nil)
        view.addObserver(self, forKeyPath: "hidden", options: .new, context: nil)
        view.addObserver(self, forKeyPath: "verticalAlignment", options: .new, context: nil)
        view.addObserver(self, forKeyPath: "horizontalAlignment", options: .new, context: nil)
    }

    private func disconnectFromView(_ view: UIView) {
        view.removeObserver(self, forKeyPath: "margin")
        view.removeObserver(self, forKeyPath: "collapsable")
        view.removeObserver(self, forKeyPath: "hidden")
        view.removeObserver(self, forKeyPath: "verticalAlignment")
        view.removeObserver(self, forKeyPath: "horizontalAlignment")
        clearConstraintsForView(view)
    }

    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        setNeedsUpdateConstraints()
    }

    // MARK: - Addition/Removal

    public override func willRemoveSubview(_ view: UIView) {
        disconnectFromView(view)
        super.willRemoveSubview(view)
        setNeedsUpdateConstraints()
    }

    public override func didAddSubview(_ subview: UIView) {
        connectToView(subview)
        super.didAddSubview(subview)
        setNeedsUpdateConstraints()
    }

    public override func exchangeSubview(at index1: Int, withSubviewAt index2: Int) {
        super.exchangeSubview(at: index1, withSubviewAt: index2)
        setNeedsUpdateConstraints()
    }

    public override func bringSubview(toFront view: UIView) {
        super.bringSubview(toFront: view)
        setNeedsUpdateConstraints()
    }

    public override func sendSubview(toBack view: UIView) {
        super.sendSubview(toBack: view)
        setNeedsUpdateConstraints()
    }

    // MARK: - Constraints

    // 

    private func setupTopConstraintToViewBottom(_ view0: UIView, view1: UIView, collection: inout [NSLayoutConstraint]) -> NSLayoutConstraint {
        func createConstraint() -> NSLayoutConstraint {
            let constraint = NSLayoutConstraint(item: view0, attribute: .top, relatedBy: .equal, toItem: view1, attribute: .bottom, multiplier: 1, constant: 0)
            constraint.priority = UILayoutPriorityRequired
            view0.topConstraint = constraint
            removeConstraintForView(view1.bottomConstraint)
            view1.bottomConstraint = constraint
            collection.append(constraint)
            return constraint
        }
        guard let constraint = view0.topConstraint else {
            return createConstraint()
        }
        if constraint.firstAttribute == .top && constraint.secondAttribute == .bottom && view0 === constraint.firstItem && view1 === constraint.secondItem {
            return constraint
        } else {
            self.removeConstraint(constraint)
            return createConstraint()
        }
    }

    private func setupLeadingConstraintToViewTrailing(_ view0: UIView, view1: UIView, collection: inout [NSLayoutConstraint]) -> NSLayoutConstraint {
        func createConstraint() -> NSLayoutConstraint {
            let constraint = NSLayoutConstraint(item: view0, attribute: .leading, relatedBy: .equal, toItem: view1, attribute: .trailing, multiplier: 1, constant: 0)
            constraint.priority = UILayoutPriorityRequired
            view0.leadingConstraint = constraint
            removeConstraintForView(view1.trailingConstraint)
            view1.trailingConstraint = constraint
            collection.append(constraint)
            return constraint
        }
        guard let constraint = view0.leadingConstraint else {
            return createConstraint()
        }
        if constraint.firstAttribute == .leading && constraint.secondAttribute == .trailing && view0 === constraint.firstItem && view1 === constraint.secondItem {
            return constraint
        } else {
            self.removeConstraint(constraint)
            return createConstraint()
        }
    }

    //

    private func setupTopConstraintToContainer(_ view: UIView, relation: NSLayoutRelation, collection: inout [NSLayoutConstraint]) -> NSLayoutConstraint {
        func createConstraint() -> NSLayoutConstraint {
            let constraint = NSLayoutConstraint(item: view, attribute: .top, relatedBy: relation, toItem: self, attribute: .top, multiplier: 1, constant: 0)
            constraint.priority = relation == .equal ? UILayoutPriorityRequired : UILayoutPriorityDefaultHigh
            view.topConstraint = constraint
            collection.append(constraint)
            return constraint
        }
        guard let constraint = view.topConstraint else {
            return createConstraint()
        }
        if constraint.firstAttribute == .top && constraint.secondAttribute == .top && view === constraint.firstItem && self === constraint.secondItem && constraint.relation == relation {
            return constraint
        } else {
            removeConstraint(constraint)
            return createConstraint()
        }
    }

    private func setupBottomConstraintToContainer(_ view: UIView, relation: NSLayoutRelation, collection: inout [NSLayoutConstraint]) -> NSLayoutConstraint {
        func createConstraint() -> NSLayoutConstraint {
            let constraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: relation, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
            constraint.priority = relation == .equal ? UILayoutPriorityRequired : UILayoutPriorityDefaultHigh
            view.bottomConstraint = constraint
            collection.append(constraint)
            return constraint
        }
        guard let constraint = view.bottomConstraint else {
            return createConstraint()
        }
        if constraint.firstAttribute == .bottom && constraint.secondAttribute == .bottom && self === constraint.firstItem && view === constraint.secondItem && constraint.relation == relation {
            return constraint
        } else {
            removeConstraint(constraint)
            return createConstraint()
        }
    }

    private func setupLeadingConstraintToContainer(_ view: UIView, relation: NSLayoutRelation, collection: inout [NSLayoutConstraint]) -> NSLayoutConstraint {
        func createConstraint() -> NSLayoutConstraint {
            let constraint = NSLayoutConstraint(item: view, attribute: .leading, relatedBy: relation, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
            constraint.priority = relation == .equal ? UILayoutPriorityRequired : UILayoutPriorityDefaultHigh
            view.leadingConstraint = constraint
            collection.append(constraint)
            return constraint
        }
        guard let constraint = view.leadingConstraint else {
            return createConstraint()
        }
        if constraint.firstAttribute == .leading && constraint.secondAttribute == .leading && view === constraint.firstItem && self === constraint.secondItem && constraint.relation == relation {
            return constraint
        } else {
            removeConstraint(constraint)
            return createConstraint()
        }
    }

    private func setupTrailingConstraintToContainer(_ view: UIView, relation: NSLayoutRelation, collection: inout [NSLayoutConstraint]) -> NSLayoutConstraint {
        func createConstraint() -> NSLayoutConstraint {
            let constraint = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: relation, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
            constraint.priority = relation == .equal ? UILayoutPriorityRequired : UILayoutPriorityDefaultHigh
            view.trailingConstraint = constraint
            collection.append(constraint)
            return constraint
        }
        guard let constraint = view.trailingConstraint else {
            return createConstraint()
        }
        if constraint.firstAttribute == .trailing && constraint.secondAttribute == .trailing && self === constraint.firstItem && view === constraint.secondItem && constraint.relation == relation {
            return constraint
        } else {
            removeConstraint(constraint)
            return createConstraint()
        }
    }

    //

    @discardableResult private func setupCenterXConstraintToContainer(_ view: UIView, collection: inout [NSLayoutConstraint]) -> NSLayoutConstraint {
        func createConstraint() -> NSLayoutConstraint {
            let constraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
            constraint.priority = UILayoutPriorityRequired
            view.centerXConstraint = constraint
            collection.append(constraint)
            return constraint
        }
        guard let constraint = view.centerXConstraint else {
            return createConstraint()
        }
        if constraint.firstAttribute == .centerX && constraint.secondAttribute == .centerX && self === constraint.firstItem && view === constraint.secondItem {
            return constraint
        } else {
            removeConstraint(constraint)
            return createConstraint()
        }
    }

    @discardableResult private func setupCenterYConstraintToContainer(_ view: UIView, collection: inout [NSLayoutConstraint]) -> NSLayoutConstraint {
        func createConstraint() -> NSLayoutConstraint {
            let constraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)
            constraint.priority = UILayoutPriorityRequired
            view.centerYConstraint = constraint
            collection.append(constraint)
            return constraint
        }
        guard let constraint = view.centerYConstraint else {
            return createConstraint()
        }
        if constraint.firstAttribute == .centerY && constraint.secondAttribute == .centerY && self === constraint.firstItem && view === constraint.secondItem {
            return constraint
        } else {
            removeConstraint(constraint)
            return createConstraint()
        }
    }

    //

    @discardableResult private func setupWidthConstraintToMinimum(_ view: UIView, collection: inout [NSLayoutConstraint]) -> NSLayoutConstraint {
        func createConstraint() -> NSLayoutConstraint {
            let constraint = NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
            constraint.priority = UILayoutPriorityFittingSizeLevel
            view.widthConstraint = constraint
            collection.append(constraint)
            return constraint
        }
        guard let constraint = view.widthConstraint else {
            return createConstraint()
        }
        if constraint.firstAttribute == .width && constraint.secondAttribute == .notAnAttribute && view === constraint.firstItem && constraint.secondItem == nil {
            return constraint
        } else {
            removeConstraint(constraint)
            return createConstraint()
        }
    }

    @discardableResult private func setupHeightConstraintToMinimum(_ view: UIView, collection: inout [NSLayoutConstraint]) -> NSLayoutConstraint {
        func createConstraint() -> NSLayoutConstraint {
            let constraint = NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
            constraint.priority = UILayoutPriorityFittingSizeLevel
            view.heightConstraint = constraint
            collection.append(constraint)
            return constraint
        }
        guard let constraint = view.heightConstraint else {
            return createConstraint()
        }
        if constraint.firstAttribute == .height && constraint.secondAttribute == .notAnAttribute && view === constraint.firstItem && constraint.secondItem == nil {
            return constraint
        } else {
            removeConstraint(constraint)
            return createConstraint()
        }
    }

    private func setupHorizontalAlignmentConstraintForView(_ view: UIView, alignment: LayoutAlignment, collection: inout [NSLayoutConstraint]) {
        let padding = self.padding
        switch alignment {
        case .center:
            view.heightConstraint = removeConstraintForView(view.heightConstraint)
            view.centerYConstraint = removeConstraintForView(view.centerYConstraint)
            setupCenterXConstraintToContainer(view, collection: &collection)
            setupWidthConstraintToMinimum(view, collection: &collection)
            let constraint2 = setupLeadingConstraintToContainer(view, relation: .greaterThanOrEqual, collection: &collection)
            constraint2.constant = padding.left + view.margin.left
            let constraint3 = setupTrailingConstraintToContainer(view, relation: .greaterThanOrEqual, collection: &collection)
            constraint3.constant = padding.right + view.margin.right
            break
        case .minimum:
            view.heightConstraint = removeConstraintForView(view.heightConstraint)
            view.centerYConstraint = removeConstraintForView(view.centerYConstraint)
            view.centerXConstraint = removeConstraintForView(view.centerXConstraint)
            let constraint0 = setupLeadingConstraintToContainer(view, relation: .equal, collection: &collection)
            constraint0.constant = padding.left + view.margin.left
            setupWidthConstraintToMinimum(view, collection: &collection)
            let constraint2 = setupTrailingConstraintToContainer(view, relation: .greaterThanOrEqual, collection: &collection)
            constraint2.constant = padding.right + view.margin.right
            break
        case .maximum:
            view.heightConstraint = removeConstraintForView(view.heightConstraint)
            view.centerYConstraint = removeConstraintForView(view.centerYConstraint)
            view.centerXConstraint = removeConstraintForView(view.centerXConstraint)
            let constraint0 = setupTrailingConstraintToContainer(view, relation: .equal, collection: &collection)
            constraint0.constant = padding.right + view.margin.right
            setupWidthConstraintToMinimum(view, collection: &collection)
            let constraint2 = setupLeadingConstraintToContainer(view, relation: .greaterThanOrEqual, collection: &collection)
            constraint2.constant = padding.left + view.margin.left
            break
        case .stretch:
            view.heightConstraint = removeConstraintForView(view.heightConstraint)
            view.centerYConstraint = removeConstraintForView(view.centerYConstraint)
            view.centerXConstraint = removeConstraintForView(view.centerXConstraint)
            let constraint0 = setupLeadingConstraintToContainer(view, relation: .equal, collection: &collection)
            constraint0.constant = padding.left + view.margin.left
            let constraint1 = setupTrailingConstraintToContainer(view, relation: .equal, collection: &collection)
            constraint1.constant = padding.right + view.margin.right
            break
        }
    }

    // ***
    private func setupVerticalAlignmentConstraintForView(_ view: UIView, alignment: LayoutAlignment, collection: inout [NSLayoutConstraint]) {
        let padding = self.padding
        switch alignment {
        case .center:
            view.widthConstraint = removeConstraintForView(view.widthConstraint)
            view.centerXConstraint = removeConstraintForView(view.centerXConstraint)
            setupCenterYConstraintToContainer(view, collection: &collection)
            setupHeightConstraintToMinimum(view, collection: &collection)
            let constraint2 = setupTopConstraintToContainer(view, relation: .greaterThanOrEqual, collection: &collection)
            constraint2.constant = padding.top + view.margin.top
            let constraint3 = setupBottomConstraintToContainer(view, relation: .greaterThanOrEqual, collection: &collection)
            constraint3.constant = padding.bottom + view.margin.bottom
            break
        case .minimum:
            view.widthConstraint = removeConstraintForView(view.widthConstraint)
            view.centerXConstraint = removeConstraintForView(view.centerXConstraint)
            view.centerYConstraint = removeConstraintForView(view.centerYConstraint)
            let constraint0 = setupTopConstraintToContainer(view, relation: .equal, collection: &collection)
            constraint0.constant = padding.top + view.margin.top
            setupHeightConstraintToMinimum(view, collection: &collection)
            let constraint2 = setupBottomConstraintToContainer(view, relation: .greaterThanOrEqual, collection: &collection)
            constraint2.constant = padding.bottom + view.margin.bottom
            break
        case .maximum:
            view.widthConstraint = removeConstraintForView(view.widthConstraint)
            view.centerXConstraint = removeConstraintForView(view.centerXConstraint)
            view.centerYConstraint = removeConstraintForView(view.centerYConstraint)
            let constraint0 = setupBottomConstraintToContainer(view, relation: .equal, collection: &collection)
            constraint0.constant = padding.bottom + view.margin.bottom
            setupHeightConstraintToMinimum(view, collection: &collection)
            let constraint2 = setupTopConstraintToContainer(view, relation: .greaterThanOrEqual, collection: &collection)
            constraint2.constant = padding.top + view.margin.top
            break
        case .stretch:
            view.widthConstraint = removeConstraintForView(view.widthConstraint)
            view.centerXConstraint = removeConstraintForView(view.centerXConstraint)
            view.centerYConstraint = removeConstraintForView(view.centerYConstraint)
            let constraint0 = setupTopConstraintToContainer(view, relation: .equal, collection: &collection)
            constraint0.constant = padding.top + view.margin.top
            let constraint1 = setupBottomConstraintToContainer(view, relation: .equal, collection: &collection)
            constraint1.constant = padding.bottom + view.margin.bottom
            break
        }
    }

    public override func setNeedsUpdateConstraints() {
        isDirtyConstraints = true
        super.setNeedsUpdateConstraints()
    }

    public override func updateConstraints() {
        if isDirtyConstraints {
            let padding = self.padding
            let orientation = self.orientation
            var before: UIView? = nil
            let count = subviews.count
            var collection = [NSLayoutConstraint]()
            var lastIndex = -1
            for index in (0..<count).reversed() {
                let view = subviews[index]
                if !view.isSkipingLayout {
                    lastIndex = index
                    break
                }
            }
            var isFirst = true
            for index in 0..<count {
                let view = subviews[index]
                if view.isSkipingLayout {
                    clearConstraintsForView(view)
                    continue
                }
                let isLast = index == lastIndex
                // Update constraints
                switch orientation {
                case .vertical:
                    if isFirst {
                        let constraint = setupTopConstraintToContainer(view, relation: .equal, collection: &collection)
                        constraint.constant = view.margin.top + padding.top
                    } else {
                        let constraint = setupTopConstraintToViewBottom(view, view1: before!, collection: &collection)
                        constraint.constant = view.margin.top + before!.margin.bottom
                    }
                    if isLast {
                        let constraint = setupBottomConstraintToContainer(view, relation: .equal, collection: &collection)
                        constraint.constant = view.margin.bottom + padding.bottom
                    }
                    setupHorizontalAlignmentConstraintForView(view, alignment: view.horizontalAlignment, collection: &collection)
                    break
                case .horizontal:
                    if isFirst {
                        let constraint = setupLeadingConstraintToContainer(view, relation: .equal, collection: &collection)
                        constraint.constant = view.margin.left + padding.left
                    } else {
                        let constraint = setupLeadingConstraintToViewTrailing(view, view1: before!, collection: &collection)
                        constraint.constant = view.margin.left + before!.margin.right
                    }
                    if isLast {
                        let constraint = setupTrailingConstraintToContainer(view, relation: .equal, collection: &collection)
                        constraint.constant = view.margin.right + padding.right
                    }
                    setupVerticalAlignmentConstraintForView(view, alignment: view.verticalAlignment, collection: &collection)
                    break
                }

                before = view
                isFirst = false
            }
            addConstraints(collection)
            isDirtyConstraints = false
        }
        super.updateConstraints()
    }

}
